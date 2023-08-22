//
//  BrowseByCategoryView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct BrowseByCategoryView: View {
    let images: [Image] = [EventsOverviewImageAssets.sample1.image,
                           EventsOverviewImageAssets.sample2.image,
                           EventsOverviewImageAssets.sample3.image]
    let items = (1...4).map { "Category \($0)" } // Replace with your own data

    let gridLayout = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Text("Browse By Category")
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
            LazyVGrid(columns: gridLayout, spacing: 10) {
                ForEach(items, id: \.self) { item in
                    GridCellView(item: item)
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }
}

struct GridCellView: View {
    let item: String

    var body: some View {
        VStack(spacing: .zero) {
            EventsOverviewImageAssets.test.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(
                    VStack(spacing: .zero) {
                        Spacer()
                        HStack {
                            Text(item)
                                .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                                    lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                                    verticalPadding: 0)
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                                .padding(.top, 4)
                                .foregroundColor(Theme.current.issWhite.color)
                            Spacer()
                        }
                        .background(Theme.current.issBlack.color.opacity(0.5))
                    }
                )
        }
        .frame(height: 100)
        .cornerRadius(12)
    }
}
