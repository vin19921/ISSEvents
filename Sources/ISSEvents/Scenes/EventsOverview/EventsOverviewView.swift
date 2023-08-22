//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSCommonUI
import ISSTheme
import SwiftUI
import SwiftUIIntrospect

public struct EventsOverviewView: View {

    @ObservedObject private var presenter: EventsOverviewPresenter
    @State private var currentPage = 0
    let colors: [Color] = [Color.red,
                           Color.green,
                           Color.blue,
                           Color.gray,
                           Color.orange]

    // MARK: Injection

    init(presenter: EventsOverviewPresenter) {
        self.presenter = presenter
        UIScrollView.appearance().showsVerticalScrollIndicator = false
//        UICollectionView.appearance().backgroundColor = .clear
    }

    // MARK: View

    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ISSNavigationBarSUI(data: navigationBarData)
                GeometryReader { _ in
                    ScrollViewReader { proxy in
                        if #available(iOS 16.0, *) {
                            List {
                                carouselView
                                    .listRowSeparator(.hidden)
                                browseByCategoryView
                                    .listRowSeparator(.hidden)
                                eventListView
                                    .listRowSeparator(.hidden)
                                //                            Spacer()
                            }
                            .listStyle(.grouped)
                            .background(Theme.current.grayDisabled.color)
                            .environment(\.defaultMinListHeaderHeight, 0)
                            .environment(\.defaultMinListRowHeight, 0)
                            .scrollContentBackground(.hidden)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
//                CarouselView()
//                CarouselViewT(content: [
//                    Color.red,
//                    Color.green,
//                    Color.blue
//                ])
                //                    Color.red
//                        .frame(width: UIScreen.main.bounds.width - 32, height: 300)
//                        .cornerRadius(12)
//                    Color.green
//                        .frame(width: UIScreen.main.bounds.width - 32, height: 300)
//                        .cornerRadius(12)
//                    Color.blue
//                        .frame(width: UIScreen.main.bounds.width - 32, height: 300)
//                        .cornerRadius(12)
//                    Color.gray
//                        .frame(width: UIScreen.main.bounds.width - 32, height: 300)
//                        .cornerRadius(12)
//                    Color.orange
//                        .frame(width: UIScreen.main.bounds.width - 32, height: 300)
//                        .cornerRadius(12)
                }
                
//                VStack {
                    //                    Spacer()
                    //                    HStack {
                    //                        Button(action: {
                    //                            // Handle button tap action
                    //                            print("Button tapped")
                    //                            //                        presenter.fetchEmployee() {_ in }
                    //                            presenter.fetchEmployees()
                    //                        }) {
                    //                            Text("Tap Me")
                    //                                .foregroundColor(.white)
                    //                                .font(.title)
                    //                                .padding()
                    //                                .background(Color.blue)
                    //                                .cornerRadius(10)
                    //                        }
                    //                    }
                    //                    Spacer()
                    //                    switch presenter.state {
                    //                    case let .success(viewModel):
                    //                        Text("Success")
                    //                        ForEach(Array(viewModel.employeeList.enumerated()), id: \.element.id) { index, section in
                    //                            Text("\(index). \(section.employeeName)")
                    //                        }
                    //                    case .isLoading:
                    //                        Text("Loading...")
                    //                    case .failure(_):
                    //                        Text("Failure")
                    //                    }
//                }
//                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
//        .background(Theme.current.grayDisabled.color)
//            .background(Color.orange)
//        }

    }
    private var sectionHeaderView: some View {
        Color.red.listRowInsets(EdgeInsets()).frame(height: .zero)
    }

    private var carouselView: some View {
        Section(header: sectionHeaderView.padding(.top)) {
            VStack(spacing: .zero) {
                PagerView(pageCount: 5,
                          currentIndex: $currentPage,
                          defaultPadding: 16,
                          cellBorderWidth: 2,
                          isSinglePage: false) {
                    // Content for each page
                    ForEach(colors, id: \.self) { color in
                        EventsOverviewCarouselCellView(image: EventsOverviewImageAssets.test.image)
                    }
                }

                HStack {
                    ForEach(0..<colors.count) { index in
                        Circle()
                            .fill(index == currentPage ? Theme.current.issBlack.color : Theme.current.issWhite.color)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.vertical)
            }
            .frame(height: 350)
//            .padding(.vertical)
        }
//        .background(Theme.current.grayDisabled.color)
        .listRowBackground(Theme.current.grayDisabled.color)
//        .foregroundColor(upcomingEvents.isEmpty ? Theme.current.amwayWhite.color : Theme.current.amwayBlack.color)
        .listRowInsets(EdgeInsets())
//        .id(EventsSections.filterSection.id)
    }

    private var browseByCategoryView: some View {
        Section(header: sectionHeaderView) {
            BrowseByCategoryView()
        }
        .listRowBackground(Theme.current.grayDisabled.color)
        .listRowInsets(EdgeInsets())
    }

    private var eventListView: some View {
        Section(header: sectionHeaderView) {
            HStack {
                Text("Latest Events")
                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
                                        verticalPadding: 0)
                Spacer()
                Text("View All")
                    .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                        lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                        verticalPadding: 0)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)
            ForEach(colors, id: \.self) { color in
                EventsListCellView(image: EventsOverviewImageAssets.test.image,
                                   onTapInfoAction: {
//                    presenter.routeToEventsDetails(eventId: "ABC")
                },
                                   onTapCartAction: {
                    print("HStack in the child view was tapped!")
                    presenter.routeToEventsCheckOut()
                })
            }
        }
        .listRowBackground(Theme.current.grayDisabled.color)
        .listRowInsets(EdgeInsets())
    }

    private var navigationBarData: ISSNavigationBarBuilder.ISSNavigationBarData {
        let rightAlignedItem = ToolBarItemDataBuilder()
            .setImage(Image(systemName: "person.crop.circle"))
            .setCallback {
//                presenter.routeToSavedEvents()
            }
            .build()
        let rightAlignedSecondItem = ToolBarItemDataBuilder()
            .setImage(Image(systemName: "magnifyingglass"))
            .setCallback {
                presenter.routeToEventsSearch()
            }
            .build()
        let leftAlignedItem = ToolBarItemDataBuilder()
            .setTitleString("iBooking")
            .setTitleFont(Theme.current.subtitle.font)
            .build()
        let toolBarItems = ToolBarItemsDataBuilder()
            .setLeftAlignedItem(leftAlignedItem)
            .setRightAlignedItem(rightAlignedItem)
            .setRightAlignedSecondItem(rightAlignedSecondItem)
            .build()
        let issNavBarData = ISSNavigationBarBuilder()
            .setToolBarItems(toolBarItems)
            .setBackgroundColor(Theme.current.backgroundGray.color)
            .setTintColor(Theme.current.issBlack.color)
//            .setForegroundColor(Theme.current.issBlack.color)
            .includeStatusBarArea(true)
            .build()
        return issNavBarData
    }
}

struct ColorItem: Identifiable {
    let id: UUID = UUID()
    let color: Color
}
