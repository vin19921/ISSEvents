//
//  EventsOverviewCarouselCellView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct EventsOverviewCarouselCellView: View {
    let image: Image

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
            Spacer()
            HStack {
                Text("Title")
                    .fontWithLineHeight(font: Theme.current.bodyOneBold.uiFont,
                                        lineHeight: Theme.current.bodyOneBold.lineHeight,
                                        verticalPadding: 0)
                Spacer()
            }
            .padding([.top, .horizontal])
            HStack {
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                    .fontWithLineHeight(font: Theme.current.bodyTwoRegular.uiFont,
                                        lineHeight: Theme.current.bodyTwoRegular.lineHeight,
                                        verticalPadding: 0)
                    .lineLimit(3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 8)
            .padding([.bottom, .horizontal])
        }
        .background(Theme.current.issWhite.color)
        .cornerRadius(12)
        .frame(width: UIScreen.main.bounds.width - 32)
        .onTapGesture {
            print("carousel cell tapped")
        }
    }
}
