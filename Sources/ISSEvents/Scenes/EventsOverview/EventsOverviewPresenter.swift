//
//  EventsOverviewPresenter.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import Combine
import Foundation
import SwiftUI

final class EventsOverviewPresenter: ObservableObject {
    private var interactor: EventsOverviewBusinessLogic
    private var router: EventsOverviewRouter?
    private var cancellables = Set<AnyCancellable>()
    @Published var state = State.isLoading

    init(interactor: EventsOverviewBusinessLogic) {
        self.interactor = interactor
    }

    // MARK: Injection

    func setRouter(_ router: EventsOverviewRouter) {
        self.router = router
    }

    func fetchEmployees() {
        fetchEmployeeTest() { result in
            switch result {
            case let .success(success):
                self.handleEventsResponse(response: success)
            case let .failure(_):
//                self.handleError(error: error)
                print("Error")
            }
        }
    }
    
    func fetchEmployeeTest(completion: @escaping (Result<EmployeeOverview.Model.Response, Error>) -> Void) {
        interactor.fetchEmployeeTest()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
//                self.isAPICallInProgress = false
                switch completion {
                case let .failure(error):
                    switch error.localizedDescription {
                    case CommonServiceError.internetFailure.localizedDescription:
                        self.state = .failure(.internet)
                    default:
                        self.state = .failure(.connectivity)
                    }
                case .finished:
                    break
                }
            }, receiveValue: { response in
//                self.isAPICallInProgress = false
//                completion(.success(response))
              
                completion(.success(response))
            })
            .store(in: &cancellables)
    }

    func handleEventsResponse(response: EmployeeOverview.Model.Response) {
        let viewModel = EmployeeOverview.Model.ViewModel(employeeList: response.employees)
        self.state = .success(viewModel)
    }
}

extension EventsOverviewPresenter {
    enum State {
        case isLoading
        case failure(FailureType)
        case success(EmployeeOverview.Model.ViewModel)
    }
    
    enum FailureType {
        case connectivity
        case internet
    }
}

// MARK: - Routing

extension EventsOverviewPresenter {
    func routeToEventsSearch() {
        router?.navigate(to: .searchScreen)
    }

    func routeToEventsCheckOut() {
        router?.navigate(to: .checkoutScreen)
    }

    func routeToEventsDetails(eventId : String) {
        router?.navigate(to: .detailsScreen(eventId: eventId))
    }
}
