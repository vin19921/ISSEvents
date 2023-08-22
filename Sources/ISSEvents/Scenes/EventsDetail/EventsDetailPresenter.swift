//
//  EventsDetailPresenter.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import SwiftUI

final class EventsDetailPresenter: ObservableObject {

    private var eventId: String = ""

    enum State {
        case isLoading
        case failure
        case success
    }

    @Published var state = State.isLoading
    
    // MARK: Injection
}

extension EventsDetailPresenter {
    func setEventId(_ eventId: String) {
        self.eventId = eventId
    }
}
