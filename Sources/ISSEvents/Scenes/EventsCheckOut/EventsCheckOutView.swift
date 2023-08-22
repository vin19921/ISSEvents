//
//  File.swift
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
//    let promoCodeViewModel: PromoCodeViewModel

//    @ObservableObject private var promoCodeControllerDelegateWrapper: EventsPromoCodeControllerDelegateWrapper
//    @State private var promoCode: String = ""
//    @EnvironmentObject var promoCodeViewModel: PromoCodeViewModel

    // MARK: Injection

    @Environment(\.presentationMode) var presentationMode

    init(presenter: EventsCheckOutPresenter) {
        self.presenter = presenter
//        _promoCodeControllerDelegateWrapper = StateObject(wrappedValue: EventsPromoCodeControllerDelegateWrapper { code in
//            // Handle the promo code here in the SwiftUI view
//            print("Promo Code Applied: \(code)")
//        })
//        let vm = PromoCodeViewModel()
//        print(vm.$promoCode)
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
//                                EventsCheckOutSummaryView(selectedQuantity: $selectedQuantity,
//                                                          singlePrice: singlePrice)
                            }
                            .padding(.top)
                        }
                        ZStack(alignment: .bottom) {
                            EventsCheckOutSummaryView(selectedQuantity: $selectedQuantity,
                                                      singlePrice: singlePrice, didTapPromoCodeButton: {
                                presenter.routeToEventsPromoCode()
                            }, didTapPayButton:  { presenter.routeToEventsPayment() })
//                            DraggableBottomSheetView()
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
//            print("promo code ::: \(vm.$promoCode)")
        }
//        .environmentObject(promoCodeViewModel)
//        .onReceive(promoCodeViewModel.$promoCode) { promoCode in
//           // This block will be executed when the promoCodeViewModel's promoCode changes
//           self.handlePromoCode(promoCode)
//       }
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

//// Conform ContentView to the SecondViewControllerDelegate protocol
//extension EventsCheckOutView: EventsPromoCodeControllerDelegate {
//    func didGetResult(result: String) {
//        // Perform any action with the passed value in the SwiftUI view.
//        valueFromSecondView = result
//        print("\(valueFromSecondView)")
//    }
//}
