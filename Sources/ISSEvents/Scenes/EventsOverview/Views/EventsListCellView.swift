//
//  EventsListCellView.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct EventsListCellView: View {
    let image: Image
    @State private var isExpanded = false
    let actionImage = [Image(systemName: "info.circle"),
                       Image(systemName: "cart"),
                       Image(systemName: "heart")]
    var onTapInfoAction: (() -> Void)?
    var onTapCartAction: (() -> Void)?

    var body: some View {
        VStack(spacing: .zero) {
            cellView
            EventCellBottomView(isExpanded: $isExpanded,
                                onTapInfoAction: onTapInfoAction,
                                onTapCartAction: onTapCartAction)
        }
        .background(Theme.current.issWhite.color)
        .cornerRadius(12)
        .padding([.top, .horizontal])
    }

    var cellView: some View {
        HStack {
            VStack(alignment: .leading, spacing: .zero) {
                HStack {
                    Text("Title")
                        .foregroundColor(Theme.current.issBlack.color)
                        .fontWithLineHeight(font: Theme.current.bodyOneMedium.uiFont,
                                            lineHeight: Theme.current.bodyOneMedium.lineHeight,
                                            verticalPadding: 0)
                        .padding(.leading)
                        .padding(.top)
                        .lineLimit(2)
                    Spacer()
                }
                .background(Theme.current.issWhite.color)
                HStack {
                    Text("Date: 03/10/2023")
                        .foregroundColor(Theme.current.issBlack.color)
                        .fontWithLineHeight(font: Theme.current.bodyTwoRegular.uiFont,
                                            lineHeight: Theme.current.bodyTwoRegular.lineHeight,
                                            verticalPadding: 0)
                        .padding(.leading)
                        .lineLimit(1)
                    Spacer()
                }
                .background(Theme.current.issWhite.color)
                HStack {
                    Text("Location: Puchong")
                        .foregroundColor(Theme.current.issBlack.color)
                        .fontWithLineHeight(font: Theme.current.bodyTwoRegular.uiFont,
                                            lineHeight: Theme.current.bodyTwoRegular.lineHeight,
                                            verticalPadding: 0)
                        .padding(.leading)
                        .padding(.bottom)
                        .lineLimit(1)
                    Spacer()
                }
                .background(Theme.current.issWhite.color)
            }
            Spacer()
            ZStack(alignment: .topTrailing) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            }
        }
        .frame(height: 100)
        .onTapGesture {
            isExpanded.toggle()
            print("\(isExpanded)")
        }
    }
}

extension VerticalAlignment {
    private enum CustomCenterAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.height / 2
        }
    }
    
    static let customCenter = VerticalAlignment(CustomCenterAlignment.self)
}
