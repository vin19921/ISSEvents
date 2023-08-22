//
//  EventsCheckOutRouter.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import UIKit

struct EventsCheckOutRouter {
    private var navigator: EventsCheckOutRoutingLogic

    init(navigator: EventsCheckOutRoutingLogic) {
        self.navigator = navigator
    }
}

extension EventsCheckOutRouter: RoutingLogic {
    enum Destination {
        case promoCodeScreen
        case paymentScreen
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .promoCodeScreen:
            navigator.navigateToPromoCodeScreen()
        case .paymentScreen:
            navigator.navigateToPaymentScreen()
        }
    }
}
