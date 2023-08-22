//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct TitleDescriptionSUIView: View {
    // MARK: - View Dependencies

    let viewData: ViewData

    // MARK: - Private Properties

    @State private var descriptionTruncates = false
    @State private var isDescriptionExpanded = true
    // Boolean to prevent multiple calls onAppear
    @State private var isTruncationDetermined = false
    // Remaining lines to truncate for event sessions
    @State private var remainingLinesToTruncate = Constant.maxNumberOfLinesWhenCollapsed
    // Array to store line limit for event sessions
    @State private var lineLimitForSessions: [Int] = []

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
//            viewData.isRegistered ? isRegisteredLabel : nil
            titleText
            descriptionText
            if descriptionTruncates {
                viewMoreButton
            }
        }
    }
}

// MARK: - View Components

private extension TitleDescriptionSUIView {
//    var isRegisteredLabel: some View {
//            HStack {
//                viewData.registeredIcon
//                    .renderingMode(.template)
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 24, height: 24)
////                    .accessibilityIdentifier(AutomationControl.registeredIcon.accessibilityIdentifier())
//                Text(viewData.registeredText)
//                    .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
//                                        lineHeight: Theme.current.bodyTwoMedium.lineHeight,
//                                        verticalPadding: 0)
////                    .accessibilityIdentifier(AutomationControl.isRegisteredLabel.accessibilityIdentifier())
//            }
//            .padding([.top,.bottom], 4)
//            .padding([.leading,.trailing], 8)
//            .background(Theme.current.darkOrange.color)
//            .foregroundColor(Theme.current.lightOrange.color)
//            .cornerRadius(4)
//        }

    var titleText: some View {
        Text(viewData.title)
            .foregroundColor(Theme.current.issBlack.color)
            .fontWithLineHeight(font: Theme.current.headline4.uiFont,
                                lineHeight: Theme.current.headline4.lineHeight,
                                verticalPadding: 0)
//            .accessibilityIdentifier(AutomationControl.titleLabel.accessibilityIdentifier())
    }

    var descriptionText: some View {
        Group {
            Text(viewData.description)
                .fontWithLineHeight(font: Theme.current.bodyOneRegular.uiFont,
                                    lineHeight: Theme.current.bodyOneRegular.lineHeight,
                                    verticalPadding: 0)
                .lineLimit(isDescriptionExpanded ? nil : Constant.maxNumberOfLinesWhenCollapsed)
//                .accessibilityIdentifier(AutomationControl.descriptionLabel.accessibilityIdentifier())

            ForEach(Array(viewData.eventSessions.enumerated()), id: \.1.self) { index, session in
                let font = session.isBold ? Theme.current.bodyOneBold.uiFont : Theme.current.bodyOneRegular.uiFont
                let lineHeight = session.isBold ? Theme.current.bodyOneBold.lineHeight : Theme.current.bodyOneRegular.lineHeight
                
                if isDescriptionExpanded {
                    Text(session.text)
                        .fontWithLineHeight(font: font,
                                            lineHeight: lineHeight,
                                            verticalPadding: 0)
                } else {
                    if lineLimitForSessions[index] > 0 {
                        Text(session.text)
                            .fontWithLineHeight(font: font, lineHeight: lineHeight, verticalPadding: 0)
                            .lineLimit(lineLimitForSessions[index])
                    }
                }
            }
        }
        .foregroundColor(Theme.current.issBlack.color)
        .background(// Determine whether the text will span more number of line than `maxNumberOfLinesWhenCollapsed`.
            // Render the text in collapsed state to determine the text size
            Text(descriptionAndAllSessions())
                .fontWithLineHeight(font: Theme.current.bodyOneRegular.uiFont,
                                    lineHeight: Theme.current.bodyOneRegular.lineHeight,
                                    verticalPadding: 0)
                .lineLimit(Constant.maxNumberOfLinesWhenCollapsed)
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        if self.isTruncationDetermined == false {
                            self.isTruncationDetermined = true
                            if geometry.size.height > 0 {
                                determineTruncation(geometry)
                            }
                        }
                    }
                })
                .hidden()
        )
    }

    var viewMoreButton: some View {
        Button {
            isDescriptionExpanded.toggle()
        } label: {
            Text(isDescriptionExpanded ? viewData.viewLessText : viewData.viewMoreText)
                .foregroundColor(Theme.current.issBlack.color)
                .underline()
                .fontWithLineHeight(font: Theme.current.bodyTwoBold.uiFont,
                                    lineHeight: Theme.current.bodyTwoBold.lineHeight,
                                    verticalPadding: 0)
        }
//        .accessibilityIdentifier(AutomationControl.viewMoreButton.accessibilityIdentifier())
    }

    private func descriptionAndAllSessions() -> String {
        let allSessions = viewData.eventSessions.reduce("", { $0 + $1.text })
        return viewData.description + allSessions
    }
}

// MARK: - Nested Types

extension TitleDescriptionSUIView {
    struct ViewData {
        let title: String
        let description: String
        let viewMoreText: String
        let viewLessText: String
//        let isRegistered: Bool
//        let registeredText: String
//        let registeredIcon: Image
        let eventSessions: [TextWithStyle] = []
    }

    enum Constant {
        static let maxNumberOfLinesWhenCollapsed = 4
        static let horizontalPadding: CGFloat = 32
        static let boldAttributes: [NSAttributedString.Key: Any] = [.font: Theme.current.bodyOneBold.uiFont]
    }
}

// MARK: - Private

private extension TitleDescriptionSUIView {
    func determineTruncation(_ geometry: GeometryProxy) {
        // Calculate the bounding box we'd need to render the text given the width from the GeometryReader.
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = Theme.current.bodyOneRegular.lineHeight
        paragraphStyle.minimumLineHeight = Theme.current.bodyOneRegular.lineHeight

        let size = CGSize(width: geometry.size.width,
                          height: .greatestFiniteMagnitude)

        let attributes: [NSAttributedString.Key: Any] = [.font: Theme.current.bodyOneRegular.uiFont,
                                                         .paragraphStyle: paragraphStyle]

        let descriptionBoundingRect = viewData.description.boundingRect(with: size,
                                                             options: .usesLineFragmentOrigin,
                                                             attributes: attributes,
                                                             context: nil)
        let numberOfLinesInDescription = Int(descriptionBoundingRect.height / Theme.current.bodyOneRegular.lineHeight)
        remainingLinesToTruncate = Constant.maxNumberOfLinesWhenCollapsed - numberOfLinesInDescription

        let lineHeight = Theme.current.bodyOneRegular.lineHeight
        let font = Theme.current.bodyOneRegular.uiFont
        let boundingSize = CGSize(width: UIScreen.main.bounds.width - Constant.horizontalPadding,
                                  height: .infinity)
        let options = NSStringDrawingOptions.usesLineFragmentOrigin.union(.usesFontLeading)

        for session in viewData.eventSessions {
            let attributedString = NSAttributedString(string: session.text,
                                                      attributes: [.font: font])
            let boundingRect = attributedString.boundingRect(with: boundingSize,
                                                             options: options,
                                                             context: nil)
            let numberOfLines = Int(ceil(boundingRect.size.height / lineHeight))

            if remainingLinesToTruncate < 0 {
                remainingLinesToTruncate = 0
            }

            lineLimitForSessions.append(remainingLinesToTruncate)
            remainingLinesToTruncate -= numberOfLines
        }

        let fullBoundingRect = descriptionAndAllSessions().boundingRect(with: size,
                                                                        options: .usesLineFragmentOrigin,
                                                                        attributes: attributes,
                                                                        context: nil)

        if fullBoundingRect.size.height > geometry.size.height {
            descriptionTruncates = true
        }
    }
}

// MARK: - Automation Ids

extension TitleDescriptionSUIView {
//    enum AutomationControl: String, AccessibilityIdentifierProvider {
//        case titleLabel
//        case descriptionLabel
//        case viewMoreButton
//        case isRegisteredLabel
//        case registeredIcon
//    }
}

struct TextWithStyle: Hashable {
    let text: String
    let isBold: Bool
    
    static func == (lhs: TextWithStyle, rhs: TextWithStyle) -> Bool {
        return lhs.text == rhs.text && lhs.isBold == rhs.isBold
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(isBold)
    }
}
