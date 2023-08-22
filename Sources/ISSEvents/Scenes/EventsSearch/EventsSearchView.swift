//
//  EventsSearchView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSCommonUI
import ISSTheme
import SwiftUI
import UIKit

public struct EventsSearchView: View {

    @ObservedObject private var presenter: EventsSearchPresenter
    @State private var searchText = ""
    @State private var isFirstResponder = false
    @State private var selectedIndices: [Int]
    @State private var isSheetPresented: [Bool] = [false, false]
    @State private var isButtonSelected: [Bool] = [false, false]
    @State private var canReopenSheetIfSelected: [Bool] = [false, false]
    @State private var currentDetent: CGFloat = 1.0 // 1.0 means fully expanded

    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: String = DateHelper.monthSymbols()[Calendar.current.component(.month, from: Date()) - 1]
    @State private var buttonText: [String] = ["Date", "Type"]
    @State private var eventType: [String] = ["Concert", "Sports", "Family-friendly", "Talk show"]
    
    @State private var selectedEventType: [Bool] = [false, false, false, false, false]
    @State private var previousSelectedEventType: [Bool] = [false, false, false, false, false]
    @State private var badgeCount: [Int?] = [nil, 0]
    @State private var isDialogPresented = false

    @State private var data: [String] = ["Item 1", "Item 2", "Item 3"]
    @State private var isRefreshing = false
    let randomColor = Color(
                red: Double.random(in: 0...1),
                green: Double.random(in: 0...1),
                blue: Double.random(in: 0...1)
            )

    // MARK: Injection

    @Environment(\.presentationMode) var presentationMode

    init(presenter: EventsSearchPresenter) {
        self.presenter = presenter
        UITableView.appearance(whenContainedInInstancesOf: [UIHostingController<EventsSearchView>.self]).backgroundColor = Theme.current.backgroundGray.uiColor
        UITableView.appearance(whenContainedInInstancesOf: [UIHostingController<EventsSearchView>.self]).separatorColor = .clear
        _selectedIndices = State(initialValue: []) // Initialize selectedIndices with an empty array
    }

    // MARK: View

    private var statusBarHeight: CGFloat {
        let window = UIApplication.shared.connectedScenes
            .map {$0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter({ $0.isKeyWindow }).first
        
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    private var xOffset: CGFloat {
        /// All iPhone devices which are of pro max or  plus category require more offset
        /// to showcase the padding value of 16.0
        let shouldChangeOffset = UIScreen.main.bounds.width >= 414
        return shouldChangeOffset ? 20.0: 16.0
    }

    public var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                ISSNavigationBarSUI(data: navigationBarData)
                    .overlay(
                        ZStack(alignment: .bottom) {
                            CustomTextField(text: $searchText,
                                            isFirstResponder: $isFirstResponder,
                                            font: Theme.current.bodyTwoMedium.uiFont, keyboardType: .alphabet,
                                            toolbarButtonTitle: "test",
                                            textFieldDidChange: { print("\(searchText)")},
                                            onTapGesture: {
                                                print("on Tap")
                                                isFirstResponder = true
                                            },
                                            placeholder: "Search for title, category, type, city, state",
                                            placeholderImage: UIImage(systemName: "magnifyingglass")
                            )
                            .frame(width: UIScreen.main.bounds.width - 36 - xOffset * 2 - 48, height: 32)
                            .padding(EdgeInsets(top: 0,
                                                leading: 12,
                                                bottom: 0,
                                                trailing: 12))
                            .background(Theme.current.issWhite.color)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .accentColor(Color.red) // Set the accent color for the text field
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Theme.current.issBlack.color.opacity(0.5), lineWidth: 2)
                            )
                        }
                        .padding(.top, statusBarHeight)
                        .frame(alignment: .leading)
                    )

                    switch presenter.state {
                    case .isLoading:
                        VStack(spacing: .zero) {
                            SearchButtonsListView(selectedIndices: $selectedIndices,
                                                  isSelected: $isButtonSelected,
                                                  isSheetPresented: $isSheetPresented,
                                                  canReopenSheet: $canReopenSheetIfSelected,
                                                  buttonText: $buttonText,
                                                  badgeCount: badgeCount,
                                                  searchTextFieldFirstResponder: $isFirstResponder,
                                                  isRefreshing: isRefreshing)

                            RefreshableScrollView(showsIndicators: false, loaderOffset: 0) { refreshComplete in
                                isRefreshing = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    refreshData(completionHandler: refreshComplete)
                                    print("refreshComplete")
                                    isRefreshing = false
                                }
                            } content: {
                                VStack(spacing: 0) {
                                    ForEach(data, id: \.self) { item in
                                        EventsListCellView(image: EventsOverviewImageAssets.test.image,
                                                           onTapCartAction: {
                                            print("HStack in the child view was tapped!")
                                            presenter.routeToEventsCheckOut()
                                        })
                                    }
                                }
                                .background(Color.clear)
                                .padding(.bottom)
                            }
                        }
                        .background(Theme.current.grayDisabled.color)
                        .onTapGesture {
                            print("onTapOutsideArea :::")
                            isFirstResponder = false
                        }

                    case .failure:
                        VStack{
                            Text("Search Scene: Failure")
                        }
                    case .success:
                        VStack{
                            Text("Search Scene: Success")
                        }
                    }

            }
            .edgesIgnoringSafeArea(.all)

            BottomSheetView(isSheetPresented: $isSheetPresented[0], content: {
                VStack(spacing: .zero) {
                    YearPickerView(selectedYear: $selectedYear,
                                   startYear: Calendar.current.component(.year, from: Date()),
                                   endYear: Calendar.current.component(.year, from: Date()) + 2
                    ) { year in
                        // Handle the selected year in the action callback
                        selectedYear = year
                        print("Selected year: \(year)")
                    }
                    
                    MonthPickerView(selectedMonth: $selectedMonth) { month in
                        // Handle the selected month in the action callback
                        print("Selected month: \(month)")
                    }
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            print("cancel")
                            isButtonSelected[0] = false
                            isSheetPresented[0] = false
                        }) {
                            HStack {
                                Text("Cancel")
                                    .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                                        lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                                        verticalPadding: 0)
                            }
                            .frame(width: UIScreen.main.bounds.width / 2 - 16 - 8, height: 40)
                            .foregroundColor(.black)
                            .background(Color.white)
                        }
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        
                        Button(action: {
                            print("apply")
                            print("\(selectedMonth) \(selectedYear)")
                            isSheetPresented[0] = false
                            isButtonSelected[0] = true
                            buttonText[0] = "\(selectedMonth) \(selectedYear)"
                        }) {
                            HStack {
                                Text("Apply")
                                    .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                                        lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                                        verticalPadding: 0)
                            }
                            .frame(width: UIScreen.main.bounds.width / 2 - 16 - 8, height: 40)
                            .foregroundColor(.white)
                            .background(Color.black)
                        }
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    }
                    .padding(.top)
                    .padding(.bottom, 40)
                    .padding(.horizontal)
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .background(Color.white)
            })
            .animation(.easeOut(duration: 0.2), value: isSheetPresented[0])

            BottomSheetView(isSheetPresented: $isSheetPresented[1], content: {
                VStack(spacing: .zero) {
                    HStack {
                        Text("Select type filter(s)")
                            .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                                lineHeight: Theme.current.bodyOneBold.lineHeight,
                                                verticalPadding: 0)
                        Spacer()
                        Button(action: {
                            print("clear")
                            selectedEventType = Array(repeating: false, count: 4)
                        }) {
                            HStack {
                                Text("Clear")
                                    .fontWithLineHeight(font: Theme.current.bodyTwoRegular.uiFont,
                                                        lineHeight: Theme.current.bodyTwoRegular.lineHeight,
                                                        verticalPadding: 0)
                                    .underlined()
                            }
                            .foregroundColor(.blue)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { scrollViewProxy in
                            HStack(alignment: .center, spacing: 8) {
                                IconButtonWithText(icon: "plus",
                                                   text: $eventType[0],
                                                   selected: $selectedEventType[0], action: {
                                    print("Concert button tapped isSelected::: \(selectedEventType[0])")
                                }, toggleEachTap: true)
                                .padding(.leading)

                                IconButtonWithText(icon: "plus",
                                                   text: $eventType[1],
                                                   selected: $selectedEventType[1], action: {
                                    print("Sports button tapped isSelected::: \(selectedEventType[1])")
                                }, toggleEachTap: true)

                                IconButtonWithText(icon: "plus",
                                                   text: $eventType[2],
                                                   selected: $selectedEventType[2], action: {
                                    print("Family-friendly button tapped isSelected::: \(selectedEventType[2])")
                                }, toggleEachTap: true)
                                
                                IconButtonWithText(icon: "plus",
                                                   text: $eventType[3],
                                                   selected: $selectedEventType[3], action: {
                                    print("Talk show button tapped isSelected::: \(selectedEventType[3])")
                                }, toggleEachTap: true)
                                .padding(.trailing)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    HStack {
                        Button(action: {
                            previousSelectedEventType = selectedEventType
                            isSheetPresented[1] = false
                            if selectedEventType.contains(true) {
                                isButtonSelected[1] = true
                                badgeCount[1] = selectedEventType.filter { $0 == true }.count
                                if let firstTrueIndex = selectedEventType.firstIndex(where: { $0 == true }) {
                                    // The firstTrueIndex contains the index of the first 'true' element
                                    print("The first 'true' element is at index:", firstTrueIndex)
                                    buttonText[1] = eventType[firstTrueIndex]
                                }
                            } else {
                                isButtonSelected[1] = false
                                buttonText[1] = "Type"
                                badgeCount[1] = 0
                            }
                        }) {
                            HStack {
                                Text("Apply")
                                    .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                                        lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                                        verticalPadding: 0)
                            }
                            .frame(width: UIScreen.main.bounds.width - 32, height: 40)
                            .foregroundColor(.white)
                            .background(previousSelectedEventType == selectedEventType ? Color.black.opacity(0.3) : Color.black)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(previousSelectedEventType == selectedEventType ? Color.black.opacity(0.3) : Color.black, lineWidth: 2)
                            )
                        }
                        .disabled(previousSelectedEventType == selectedEventType)
                    }
                    .padding(.top)
                    .padding(.bottom, 40)
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 168)
                .background(Color.white)
            })
            .animation(.easeOut(duration: 0.2), value: isSheetPresented[1])

            DialogView(isDialogPresented: $isDialogPresented, frameHeight: 300, content: {
                VStack {
                    Text("This is dialog")
                    Spacer()
                }
                .frame(height: 300)
                .frame(maxWidth: .infinity)
                .background(Color.white)
            })
            .animation(.easeOut(duration: 0.4), value: isDialogPresented)
        }
    }

    private func formattedMonthYear(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    private func toggleSelection(index: Int) {
        if isSelected(index: index) {
            selectedIndices.removeAll { $0 == index }
        } else {
            selectedIndices.append(index)
        }
    }

    private func isSelected(index: Int) -> Bool {
        selectedIndices.contains(index)
    }

    private var navigationBarData: ISSNavigationBarBuilder.ISSNavigationBarData {
        let leftAlignedItem = ToolBarItemDataBuilder()
            .setImage(Image(systemName: "chevron.backward"))
            .setCallback {
                isFirstResponder = false
                self.presentationMode.wrappedValue.dismiss()
            }
            .build()
        let toolBarItems = ToolBarItemsDataBuilder()
            .setLeftAlignedItem(leftAlignedItem)
            .build()
        let issNavBarData = ISSNavigationBarBuilder()
            .setToolBarItems(toolBarItems)
            .setBackgroundColor(Theme.current.backgroundGray.color)
            .setTintColor(Theme.current.issBlack.color)
            .includeStatusBarArea(true)
            .build()
        return issNavBarData
    }

    func refreshData(completionHandler: (() -> Void)? = nil) {
        data.append("Item \(data.count+1)")
        completionHandler?()
   }
}


struct SizeCalculator: ViewModifier {

    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
    
}

extension View {
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}

struct MonthYearPicker: View {
    @Binding var selectedMonthYear: Date

    var body: some View {
        HStack {
            DatePicker("", selection: $selectedMonthYear, displayedComponents: [.date])
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
        }
        .frame(width: UIScreen.main.bounds.width, height: 300)
        .background(Color.yellow)
    }
}

import SwiftUI

struct UnderlinedText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .padding(.top) // Adjust the padding to control the distance between the text and the underline
//                    .foregroundColor(.blue) // Set the underline color here
                    .alignmentGuide(.bottom) { $0.height } // Ensure the underline aligns with the bottom of the text
            )
    }
}

extension View {
    func underlined() -> some View {
        self.modifier(UnderlinedText())
    }
}
