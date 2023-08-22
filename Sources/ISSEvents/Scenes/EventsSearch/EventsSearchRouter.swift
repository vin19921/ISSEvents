//
//  EventsSearchRouter.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import UIKit

struct EventsSearchRouter {
    private var navigator: EventsSearchRoutingLogic

    init(navigator: EventsSearchRoutingLogic) {
        self.navigator = navigator
    }
}

extension EventsSearchRouter: RoutingLogic {
    enum Destination {
        case checkoutScreen
        case detailsScreen(eventId: String)
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .checkoutScreen:
            navigator.navigateToCheckOutScreen()
        case let .detailsScreen(eventId):
            navigator.navigateToDetailsScreen(eventId: eventId)
        }
    }
}
