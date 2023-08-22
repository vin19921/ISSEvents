//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct EventsCheckOutSummaryView: View {
    @Binding var selectedQuantity: Int
    let singlePrice: Float
    let didTapPromoCodeButton: () -> Void
    let didTapPayButton: () -> Void
    @StateObject private var promoCodeViewModel = PromoCodeViewModel.shared
    private let minHeight: CGFloat = 250
    private let maxHeight: CGFloat = UIScreen.main.bounds.height - 100
    @State private var frameHeight: CGFloat = 250
    @State private var dragOffset: CGFloat = 0
    @State private var isDragEnded = false
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Text("Subtotal")
                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
                                        verticalPadding: 0)
                Spacer()
                Text(formattedSubtotal())
                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
                                        verticalPadding: 0)
            }
            .padding(.horizontal)
            .padding(.top)

            HStack {
                Text("Service Charge")
                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
                                        verticalPadding: 0)
                Spacer()
                Text("RM10.00")
                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
                                        verticalPadding: 0)
            }
            .padding(.horizontal)
            .padding(.top, 8)

            Rectangle().frame(height: 1).padding()

            Button(action: {
                print("Tap promo code btn")
                if promoCodeViewModel.promoCode.isEmpty {
                    didTapPromoCodeButton()
                } else {
                    promoCodeViewModel.resetPromoCode()
                }
            }) {
                HStack {
                    if promoCodeViewModel.promoCode.isEmpty {
                        Image(systemName: "ticket")
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.black)

                        Text("Apply promo code to get discount")
                            .fontWithLineHeight(font: Theme.current.bodyOneRegular.uiFont,
                                                lineHeight: Theme.current.bodyOneRegular.lineHeight,
                                                verticalPadding: 0)
                            .foregroundColor(Color.black)
                        
                        Spacer()

                        Image(systemName: "chevron.right")
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.black)
                    } else {
                        Image(systemName: "xmark")
                            .frame(width: 20, height: 20)
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(Color.red)

                        Text(promoCodeViewModel.promoCode)
                            .fontWithLineHeight(font: Theme.current.bodyOneRegular.uiFont,
                                                lineHeight: Theme.current.bodyOneRegular.lineHeight,
                                                verticalPadding: 0)
                            .foregroundColor(Color.black)

                        Spacer()

                        Text("- RM " + String(format: "%.2f", promoCodeViewModel.promoPrice))
                            .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                                lineHeight: Theme.current.bodyOneBold.lineHeight,
                                                verticalPadding: 0)
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.horizontal)
            }

            Rectangle().frame(height: 1).padding()

            HStack {
                Text("Grand Total")
                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
                                        verticalPadding: 0)
                Spacer()
                Text(formattedGrandtotal())
                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
                                        verticalPadding: 0)
            }
            .padding(.horizontal)

            Spacer()

            Button(action: {
                print("Pay btn")
                didTapPayButton()
            }) {
//                HStack(alignment: .center) {
//                    Spacer()
//                    Text("Pay")
//                        .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
//                                            lineHeight: Theme.current.bodyTwoMedium.lineHeight,
//                                            verticalPadding: 0)
//                    Spacer()
//                }
//                .frame(height: 40)
//                .foregroundColor(.white)
//                .background(Color.black)
//                .padding(.all)

                Text("Pay")
                    .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                        lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                        verticalPadding: 8)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity) // Expands the button to full screen width
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 12)
//                    .foregroundColor(.black)
//            )
        }
//        .frame(minHeight: 200, idealHeight: 250)
        .frame(height: frameHeight)
        .background(Color.white)
//        .offset(x: 0, y: dragOffset)
//        .gesture(DragGesture()
//            .onChanged { gesture in
//                if gesture.translation.height < 0 {
//                    dragOffset = abs(gesture.translation.height)
//                    if frameHeight + dragOffset > maxHeight {
//                        frameHeight = maxHeight
//                        isDragEnded = true
//                    } else {
//                        frameHeight = frameHeight + dragOffset
//                    }
//                } else {
//                    dragOffset = gesture.translation.height
//                    if frameHeight - dragOffset < minHeight {
//                        frameHeight = minHeight
//                        isDragEnded = true
//                    } else {
//                        frameHeight = frameHeight - dragOffset
//                    }
//                }
//                print("dragging...")
//            }
//            .onEnded { gesture in
//                if isDragEnded {
//                    // Perform actions when the end threshold is reached
//                    print("Drag ended at threshold")
//                    isDragEnded = false // Reset the flag
//                } else {
//                    // Perform other actions when drag ends
//                    print("Drag ended normally")
//                    dragOffset = 0
//                }
//            })
    }

    private func formattedSubtotal() -> String {
        let subtotalValue = Float(selectedQuantity) * singlePrice
        return String(format: "RM%.2f", subtotalValue)
    }

    private func formattedGrandtotal() -> String {
        let grandtotalValue = Float(selectedQuantity) * singlePrice + 10 - Float(promoCodeViewModel.promoPrice)
        return String(format: "RM%.2f", grandtotalValue)
    }
}

struct DraggableBottomSheetView: View {
    @State private var verticalOffset: CGFloat = UIScreen.main.bounds.height
    @State private var lastVerticalPosition: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .foregroundColor(.blue)
                    .background(Color.white)
                    .offset(x: 0, y: verticalOffset)
                    .gesture(DragGesture()
                                .onChanged { gesture in
                                    let newVerticalPosition = lastVerticalPosition + gesture.translation.height
                                    
                                    if newVerticalPosition >= 0 && newVerticalPosition <= geometry.size.height - 100 {
                                        verticalOffset = newVerticalPosition
                                    }
                                }
                                .onEnded { gesture in
                                    lastVerticalPosition = verticalOffset
                                })
            }
        }
//        .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
