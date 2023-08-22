//
//  EventsOverviewRouter.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import UIKit

struct EventsOverviewRouter {
    private var navigator: EventsRoutingLogic

    init(navigator: EventsRoutingLogic) {
        self.navigator = navigator
    }
}

extension EventsOverviewRouter: RoutingLogic {
    enum Destination {
        case searchScreen
        case checkoutScreen
        case detailsScreen(eventId: String)
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .searchScreen:
            navigator.navigateToSearchScreen()
        case .checkoutScreen:
            navigator.navigateToCheckOutScreen()
        case let .detailsScreen(eventId):
            navigator.navigateToDetailsScreen(eventId: eventId)
        }
    }
}
