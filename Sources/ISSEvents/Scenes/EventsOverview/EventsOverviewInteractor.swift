//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 15/06/2023.
//

import Foundation

protocol EventsOverviewBusinessLogic {
}

final class EventsOverviewInteractor: EventsOverviewBusinessLogic {
    private var provider: EventsDataProviderLogic
    private var cancellables = Set<AnyCancellable>()

    init(provider: EventsDataProviderLogic) {
        self.provider = provider
    }
}
