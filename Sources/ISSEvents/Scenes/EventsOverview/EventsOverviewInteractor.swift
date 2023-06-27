//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 15/06/2023.
//

import Combine
import Foundation

protocol EventsOverviewBusinessLogic {
    typealias EventsHandler = (Result<EventsOverviewWrapper, Error>) -> Void
    func fetchEvents(completion: @escaping EventsHandler)
    typealias EmployeeHandler = (Result<EmployeesResponse, Error>) -> Void
    func fetchEmployee(completion: @escaping EmployeeHandler)
}

final class EventsOverviewInteractor: EventsOverviewBusinessLogic {
    private var provider: EventsDataProviderLogic
    private var cancellables = Set<AnyCancellable>()

    init(provider: EventsDataProviderLogic) {
        self.provider = provider
    }

    func fetchEvents(completion: @escaping EventsHandler) {
        provider.fetchEvents(completion: completion)
    }

    func fetchEmployee(completion: @escaping EmployeeHandler) {
        provider.fetchEmployee(completion: completion)
    }
}
