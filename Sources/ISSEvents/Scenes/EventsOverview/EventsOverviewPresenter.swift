//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 15/06/2023.
//

import Combine
import Foundation
import SwiftUI

final class EventsOverviewPresenter: ObservableObject {
    private var interactor: EventsOverviewBusinessLogic
    private var router: EventsOverviewRouter?

    init(interactor: EventsOverviewBusinessLogic) {
        self.interactor = interactor
    }

    // MARK: Injection

    func setRouter(_ router: EventsOverviewRouter) {
        self.router = router
    }
}
