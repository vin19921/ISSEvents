//
//  File.swift
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
//    let didTapOnContentButton: (EventDetailCell.ActionType?) -> Void
//    let isRegistered: Bool
//    let eventsMode: EventsMode

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            sectionTitle
            VStack(alignment: .leading, spacing: .zero) {
                ForEach(eventDetailSection) { section in
                    eventSectionCell(section: section)
//                    switch section.displayType {
//                    case .eventType, .regRequired:
////                        if eventsMode == .weblinks {
//                            eventSectionCell(section: section)
////                        }
//                    case .eventDate, .eventLocation:
//                        eventSectionCell(section: section)
//                    case .ticketCapacity, .language:
////                        if eventsMode == .booking {
//                            eventSectionCell(section: section)
////                        }
//                    case .none:
//                        eventSectionCell(section: section)
//                    }
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
//            .accessibilityIdentifier(AutomationControl.sectionTitle.accessibilityIdentifier())
    }

    func eventSectionCell(section: EventDetailCell.ViewData) -> some View {
        EventDetailCell(viewData: section
//                        ,
//                        didTapOnButton: { action in didTapOnContentButton(action) },
//                        isRegistered: isRegistered
//                        ,
//                        eventMode: eventsMode
        )
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

// MARK: - Automation Ids

extension EventDetailSection {
//    enum AutomationControl: String, AccessibilityIdentifierProvider {
//        case sectionTitle
//    }
}

