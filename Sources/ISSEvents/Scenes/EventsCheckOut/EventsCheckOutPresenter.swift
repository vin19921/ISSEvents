//
//  EventsCheckOutPresenter.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI

final class EventsCheckOutPresenter: ObservableObject {

    private var router: EventsCheckOutRouter?
    @ObservedObject var promoCodeViewModel = PromoCodeViewModel()

    enum State {
        case isLoading
        case failure
        case success
    }

    @Published var state = State.isLoading
    
    // MARK: Injection

    func setRouter(_ router: EventsCheckOutRouter) {
        self.router = router
    }
}

// MARK: - Routing

extension EventsCheckOutPresenter {
    func routeToEventsPromoCode() {
        router?.navigate(to: .promoCodeScreen)
    }

    func routeToEventsPayment() {
        router?.navigate(to: .paymentScreen)
    }
}

