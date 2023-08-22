//
//  EventsPromoCodeView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSCommonUI
import ISSTheme
import SwiftUI

public struct EventsPromoCodeView: View {
    
    @ObservedObject private var presenter: EventsPromoCodePresenter
    @State private var isFirstResponder = false
    @State private var searchText = ""
    let promoList: [String] = ["Hot Deals 20",
                               "Cash Back 10%",
                               "PWP"]
    @State private var inputPromoList: [String] = []
    @StateObject private var viewModel = PromoCodeViewModel.shared
    @State private var isSheetPresented = false
    @State private var promoCodeTitle = ""
    
    // MARK: Injection
    
    @Environment(\.presentationMode) private var presentationMode
    
    init(presenter: EventsPromoCodePresenter) {
        self.presenter = presenter
    }

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
            VStack(spacing: .zero) {
                ISSNavigationBarSUI(data: navigationBarData)
                    .overlay(
                        ZStack {
                            CustomTextField(text: $searchText,
                                            isFirstResponder: $isFirstResponder,
                                            font: Theme.current.bodyTwoMedium.uiFont, keyboardType: .alphabet,
                                            toolbarButtonTitle: "test",
                                            textFieldDidChange: { print("\(searchText)")},
                                            onTapGesture: {
                                                print("on Tap")
                                                isFirstResponder = true
                                            },
                                            placeholder: "Enter Promo Code",
                                            placeholderImage: UIImage(systemName: "magnifyingglass"),
                                            textFieldDidReturn: {
                                if !searchText.isEmpty {
                                    PromoCodeViewModel.shared.promoCode = searchText
                                    inputPromoList.append(searchText)
                                }
                                isFirstResponder = false
                                            }
                            )
                            .frame(width: UIScreen.main.bounds.width - 36 - xOffset * 2 - 48, height: 32)
                            .padding(EdgeInsets(top: 0,
                                                leading: 12,
                                                bottom: 0,
                                                trailing: 12))
                            .background(Theme.current.issWhite.color)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
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
                        ScrollView {
                            VStack(spacing: .zero) {
                                
                                promoButtonsView(promoList: inputPromoList)
                                promoButtonsView(promoList: promoList)
                                Spacer()
                            }
                            .padding(.top)
                        }
                    }
                    .background(Theme.current.issWhite.color)

                case .failure:
                    VStack{
                        Text("Promo Code Scene: Failure")
                    }
                case .success:
                    VStack{
                        Text("Promo Code Scene: Success")
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)

            BottomSheetView(isSheetPresented: $isSheetPresented, content: {
                ScrollView {
                    VStack(spacing: .zero) {
                        HStack {
                            Text(promoCodeTitle)
                                .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                                    lineHeight: Theme.current.bodyOneBold.lineHeight,
                                                    verticalPadding: 0)
                        }
                        Text("\(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) \(promoCodeTitle) ")
                            .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                                lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                                verticalPadding: 0)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .padding(.bottom, 40)
                .background(Color.white)
            })
            .animation(.easeOut(duration: 0.2), value: isSheetPresented)

        }
    }

    private var navigationBarData: ISSNavigationBarBuilder.ISSNavigationBarData {
        let leftAlignedItem = ToolBarItemDataBuilder()
            .setImage(Image(systemName: "chevron.backward"))
            .setCallback {
                self.isFirstResponder = false
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

    private func promoButtonsView(promoList: [String]) -> some View {
        return ForEach(promoList, id: \.self) { promo in
            Button(action: {
                print("tapped \(promo)")
                promoCodeTitle = promo
                isSheetPresented.toggle()
                isFirstResponder = false
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(promo)")
                            .fontWithLineHeight(font: Theme.current.bodyTwoBold.uiFont,
                                                lineHeight: Theme.current.bodyTwoBold.lineHeight,
                                                verticalPadding: 0)
                        Text("\(promo) \(promo) \(promo) \(promo) \(promo) ")
                            .fontWithLineHeight(font: Theme.current.bodyThreeRegular.uiFont,
                                                lineHeight: Theme.current.bodyThreeRegular.lineHeight,
                                                verticalPadding: 0)
                            .lineLimit(1)
                    }

                    Spacer()

                    Button(action: {
                        print("tapped \(promo) apply button")
                        viewModel.applyPromoCode(code: promo, price: 5.00)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text("Apply")
                                .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                                    lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                                    verticalPadding: 0)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .foregroundColor(Color.black)
            }

            Rectangle().frame(height: 1).padding()
        }
    }
}

