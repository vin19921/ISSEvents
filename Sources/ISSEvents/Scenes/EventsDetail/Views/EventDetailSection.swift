//
//  EventDetailSection.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import SwiftUI

struct EventDetailSection: View {
    // MARK: - View Dependencies

    let eventsDetailSectionTitle: String
    var eventDetailSection: [EventDetailCell.ViewData]

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            sectionTitle
            VStack(alignment: .leading, spacing: .zero) {
                ForEach(eventDetailSection) { viewData in
                    eventSectionCell(viewData: viewData)
                }
            }
        }
        .padding(.horizontal, Constants.defaultPadding)
        .padding(.vertical, Constants.verticalPadding)
        .background(Theme.current.white.color)
        .cornerRadius(Constants.cornerRadius)
    }
}

// MARK: - View Components

private extension EventDetailSection {
    var sectionTitle: some View {
        Text(eventsDetailSectionTitle)
            .foregroundColor(Theme.current.issBlack.color)
            .fontWithLineHeight(font: Theme.current.subtitle.uiFont,
                                lineHeight: Theme.current.subtitle.lineHeight,
                                verticalPadding: .zero)
    }

    func eventSectionCell(viewData: EventDetailCell.ViewData) -> some View {
        EventDetailCell(viewData: viewData)
    }
}

// MARK: - Constants

private extension EventDetailSection {
    enum Constants {
        static let defaultPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        static let verticalPadding: CGFloat = 24
        static let detailsSpacing: CGFloat = 16.0
    }
}
