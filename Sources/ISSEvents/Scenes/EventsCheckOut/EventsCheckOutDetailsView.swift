//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct EventsCheckOutDetailsView: View {
    @Binding var selectedQuantity: Int

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
//            HStack {
//            Spacer()
            EventsOverviewImageAssets.test.image
                .resizable()
//                    .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 32, height: 80)
//            }
            Spacer()

            HStack {
                Text("Event Title")
                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
                                        verticalPadding: 0)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)

            HStack(spacing: 8) {
                Image(systemName: "xmark")
                Text("type")
                    .fontWithLineHeight(font: Theme.current.bodyTwoRegular.uiFont,
                                        lineHeight: Theme.current.bodyTwoRegular.lineHeight,
                                        verticalPadding: 0)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 8)

            HStack(spacing: 8) {
                Image(systemName: "xmark")
                Text("type")
                    .fontWithLineHeight(font: Theme.current.bodyTwoRegular.uiFont,
                                        lineHeight: Theme.current.bodyTwoRegular.lineHeight,
                                        verticalPadding: 0)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 8)

            HStack {
                Text("RM50")
                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
                                        verticalPadding: 0)
                Spacer()
//                Text("1")
//                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
//                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
//                                        verticalPadding: 0)
                HStack(spacing: 16) {
                    Button(action: {
                        decrementQuantity()
                    }) {
                        HStack {
                            Image(systemName: "minus")
                                .frame(width: 20, height: 20)
                                .foregroundColor(selectedQuantity <= 1 ? .gray : .black)
//                                .background(Color.yellow)

                        }
                    }
                    .disabled(selectedQuantity <= 1)

                    Text("\(selectedQuantity)")
                        .fontWithLineHeight(font: Theme.current.bodyOneMedium.uiFont,
                                            lineHeight: Theme.current.bodyOneMedium.lineHeight,
                                            verticalPadding: 0)

                    Button(action: {
                        incrementQuantity()
                    }) {
                        HStack {
                            Image(systemName: "plus")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
//                                .background(Color.yellow)
                        }
                    }
                }
            }
            .padding(.all)
        }
//        .padding(.top)
        .background(Theme.current.issWhite.color)
        .cornerRadius(12)
        .frame(width: UIScreen.main.bounds.width - 32, height: 250)
    }

    private func decrementQuantity() {
        if selectedQuantity > 1 {
            selectedQuantity -= 1
//            yearSelected(selectedYear)
        }
        print("selectedQuantity::: \(selectedQuantity)")
    }

    private func incrementQuantity() {
//        if selectedYear < endYear {
        selectedQuantity += 1
        print("selectedQuantity::: \(selectedQuantity)")
//            yearSelected(selectedYear)
//        }
    }
}