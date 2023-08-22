//
//  EventDetailCell.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct EventDetailCell: View {

    // MARK: - View Dependencies

    let viewData: ViewData

    // MARK: - Constants

    private enum Constants {
        static let defaultSpacing: CGFloat = 16
        static let ctaTopPadding: CGFloat = 10
        static let iconSize: CGFloat = 24
    }

    // MARK: - Body

    var body: some View {
        HStack(alignment: .top, spacing: Constants.defaultSpacing) {
            titleIcon
            titleText
        }
    }

    func textWithNewlines(_ input: String) -> [LineView] {
        let lines = input.components(separatedBy: "\n")
        return lines.map { LineView(text: Text($0)) }
    }
}

// MARK: - View Components

private extension EventDetailCell {
    var titleText: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ForEach(textWithNewlines(viewData.title)) { line in
                line
            }
        }.padding(.top)
    }

    var titleIcon: some View {
        viewData.icon
            .aspectRatio(contentMode: .fit)
            .frame(width: Constants.iconSize, height: Constants.iconSize)
            .offset(x: 0, y: -2)
            .padding(.top)
    }
}

// MARK: - EventDetailCell Data

extension EventDetailCell {
    struct ViewData: Identifiable {
        var id = UUID().uuidString
        var title: String
        var icon: Image?
        var cta: String = ""
        var actionType: ActionType?
        var displayType: DisplayType?
        var isThresholdColor: Bool = false
        var lineLimit: Int?
    }

    enum ActionType {
        case addToCalendar, getDirections
    }

    enum DisplayType {
        case eventType, regRequired, eventDate, eventLocation, ticketCapacity, language
    }
}

struct LineView: View, Identifiable {
    let id = UUID()
    let text: Text
    
    var body: some View {
        HStack {
            text
                .foregroundColor(Theme.current.issBlack.color)
                .fontWithLineHeight(font: Theme.current.bodyTwoMedium.uiFont,
                                    lineHeight: Theme.current.bodyTwoMedium.lineHeight,
                                    verticalPadding: 0)
                .lineLimit(nil)
            Spacer()
        }
    }
}
