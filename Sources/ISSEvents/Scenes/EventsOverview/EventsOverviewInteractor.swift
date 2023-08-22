//
//  EventsOverviewInteractor.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import Combine
import Foundation

protocol EventsOverviewBusinessLogic {
    typealias EventsHandler = (Result<EventsOverviewWrapper, Error>) -> Void
    func fetchEvents(completion: @escaping EventsHandler)
    typealias EmployeeHandler = (Result<EmployeesResponse, Error>) -> Void
    func fetchEmployeeTest() -> AnyPublisher<EmployeeOverview.Model.Response, Error>
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

    func fetchEmployeeTest() -> AnyPublisher<EmployeeOverview.Model.Response, Error> {
        return Future<EmployeeOverview.Model.Response, Error> { [weak self] promise in
            guard let self = self else { return promise(.failure(CommonServiceError.invalidDataInFile)) }

            self.provider.fetchEmployeeTest()
                .sink { completion in
                    if case let .failure(error) = completion {
                        promise(.failure(error))
                    }
                } receiveValue: { response in
                    promise(.success(EmployeeOverview.Model.Response(status: response.status,
                                                                     employees: response.data,
                                                                     message: response.message)))
                }.store(in: &self.cancellables)
        }.eraseToAnyPublisher()
    }
}
