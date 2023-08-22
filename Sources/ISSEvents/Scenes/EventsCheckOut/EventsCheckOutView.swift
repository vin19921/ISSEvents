//
//  EventsCheckOutView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSCommonUI
import ISSTheme
import SwiftUI

public struct EventsCheckOutView: View {

    @ObservedObject private var presenter: EventsCheckOutPresenter
    @State private var selectedQuantity = 1
    private let singlePrice: Float = 50.00
    @StateObject private var promoCodeViewModel = PromoCodeViewModel.shared

    // MARK: Injection

    @Environment(\.presentationMode) var presentationMode

    init(presenter: EventsCheckOutPresenter) {
        self.presenter = presenter
    }

    public var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: .zero) {
                ISSNavigationBarSUI(data: navigationBarData)

                switch presenter.state {
                case .isLoading:
                    VStack(spacing: .zero) {
                        ScrollView {
                            VStack(spacing: .zero) {
                                EventsCheckOutDetailsView(selectedQuantity: $selectedQuantity)
                                Spacer()
                            }
                            .padding(.top)
                        }
                        ZStack(alignment: .bottom) {
                            EventsCheckOutSummaryView(selectedQuantity: $selectedQuantity,
                                                      singlePrice: singlePrice, didTapPromoCodeButton: {
                                presenter.routeToEventsPromoCode()
                            }, didTapPayButton:  { presenter.routeToEventsPayment() })
                        }
                    }
                    .background(Theme.current.grayDisabled.color)
                case .failure:
                    VStack{
                        Text("Checkout Scene: Failure")
                    }
                case .success:
                    VStack{
                        Text("Checkout Scene: Success")
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .background(Theme.current.grayDisabled.color)
        }
        .onAppear {
            print("promo code ::: \(promoCodeViewModel.promoCode)")
        }
    }

    private var navigationBarData: ISSNavigationBarBuilder.ISSNavigationBarData {
        let leftAlignedItem = ToolBarItemDataBuilder()
            .setImage(Image(systemName: "chevron.backward"))
            .setCallback {
                promoCodeViewModel.resetPromoCode()
                self.presentationMode.wrappedValue.dismiss()
            }
            .build()
        let leftAlignedSecondItem = ToolBarItemDataBuilder()
            .setTitleString("Checkout")
            .setTitleFont(Theme.current.subtitle.font)
            .build()
        let toolBarItems = ToolBarItemsDataBuilder()
            .setLeftAlignedItem(leftAlignedItem)
            .setLeftAlignedSecondItem(leftAlignedSecondItem)
            .build()
        let issNavBarData = ISSNavigationBarBuilder()
            .setToolBarItems(toolBarItems)
            .setBackgroundColor(Theme.current.backgroundGray.color)
            .setTintColor(Theme.current.issBlack.color)
            .includeStatusBarArea(true)
            .build()
        return issNavBarData
    }

    private func handlePromoCode(_ promoCode: String) {
        // Handle the promo code here in the CheckOutView
        print("Promo Code Applied: \(promoCode)")
        // You can update any other state variables or perform any action here
        // based on the applied promo code
    }
}
