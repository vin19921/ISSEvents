//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import Foundation

final class EventsSearchPresenter: ObservableObject {

    private var router: EventsSearchRouter?

    enum State {
        case isLoading
        case failure
        case success
    }

    @Published var state = State.isLoading

    // MARK: Injection

    func setRouter(_ router: EventsSearchRouter) {
        self.router = router
    }
}


// MARK: - Routing

extension EventsSearchPresenter {
    func routeToEventsCheckOut() {
        router?.navigate(to: .checkoutScreen)
    }
}
