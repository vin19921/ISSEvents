//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
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
        case detailsScreen(eventId: String)
    }

    func navigate(to destination: Destination) {
        switch destination {
        case let .detailsScreen(eventId):
            navigator.navigateToDetailsScreen(eventId: eventId)
        }
    }
}
