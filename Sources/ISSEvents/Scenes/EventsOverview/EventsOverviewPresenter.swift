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
    private var cancellables = Set<AnyCancellable>()
    @Published var state = State.isLoading

    init(interactor: EventsOverviewBusinessLogic) {
        self.interactor = interactor
    }

    // MARK: Injection

    func setRouter(_ router: EventsOverviewRouter) {
        self.router = router
    }
    
//    func fetchEvents(request: request, type: type) { [weak self] result in
//        switch result {
//        case let .success(response):
//            self?.handleEventsResponse(response: response)
//            if var citySearchData = self?.citySearchData {
//                citySearchData.searchResults = response.scheduledEvents.count
//                self?.trackCitySearchAnalytics(citySearchData: citySearchData)
//                self?.citySearchData = nil
//            }
//        case .failure:
//            self?.showSearchEventsError = true
//        }
//    }

    func fetchEvents(completion: @escaping (Result<EventsOverviewWrapper, Error>) -> Void)
    {
        // Convert response of Interactor to ViewModel.
//        guard !isAPICallInProgress else { return }
//        isAPICallInProgress = true
//        interactor.fetchEvents(completion: completion)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] completion in
//                guard let self = self else { return }
//                self.isAPICallInProgress = false
//                switch completion {
//                case let .failure(error):
//                    switch error.localizedDescription {
//                    case CommonServiceError.internetFailure.localizedDescription:
//                        self.state = .failure(.internet)
//                    default:
//                        self.state = .failure(.connectivity)
//                    }
//                case .finished:
//                    break
//                }
//            }, receiveValue: { response in
////                self.isAPICallInProgress = false
////                if type != .preview, !request.scheduledEvent.previewPaginatedEvents {
////                    self.hasMoreScheduledEvents = response.hasMoreScheduledEvents
////                    self.showPaginationAPIError = false
////                }
////
////                if request.registeredEvent != nil {
////                    self.registeredResponse = response
////                }
//                completion(.success(response))
//            })
//            .store(in: &cancellables)
        
        interactor.fetchEvents(completion: { [weak self] result in
//            guard let self = self else { return }
//            self.inProgress = false
            switch result {
            case let .success(result):
//                guard let appConfigData = appConfigDataModel?.config,
//                      let appConfiguration = self.convertToViewModel(appConfigData: appConfigData)
//                else {
//                    self.logger.debug("AppConfigurationManager: Invalid app config data or Unable to parse app config data into AppConfiguration model")
//                    completion(.failure("CommonServiceError.invalidDataInFile"))
//                    return
//                }
//                self.appConfiguration = appConfiguration
//                self.updateEnvironment(appConfiguration: appConfiguration)
//
//                let featureFlags = appConfiguration.platforms.ios.featureFlags
//                self.updateFeatureFlags(featureFlags: featureFlags)
                completion(.success(result))

            case let .failure(error):
//                self.logger.error("AppConfigurationManager: fetch app config error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        })

    }

    func fetchEmployee(completion: @escaping (Result<EmployeesResponse, Error>) -> Void)
    {
        
        interactor.fetchEmployee(completion: { [weak self] result in
//            guard let self = self else { return }
//            self.inProgress = false
            switch result {
            case let .success(result):
//                guard let appConfigData = appConfigDataModel?.config,
//                      let appConfiguration = self.convertToViewModel(appConfigData: appConfigData)
//                else {
//                    self.logger.debug("AppConfigurationManager: Invalid app config data or Unable to parse app config data into AppConfiguration model")
//                    completion(.failure("CommonServiceError.invalidDataInFile"))
//                    return
//                }
//                self.appConfiguration = appConfiguration
//                self.updateEnvironment(appConfiguration: appConfiguration)
//
//                let featureFlags = appConfiguration.platforms.ios.featureFlags
//                self.updateFeatureFlags(featureFlags: featureFlags)
                completion(.success(result))

            case let .failure(error):
//                self.logger.error("AppConfigurationManager: fetch app config error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        })

    }

//    func fetchEmployeeTest() -> AnyPublisher<EmployeeOverview.Model.Response, Error> {
//    }
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
                let viewModel = EmployeeOverview.Model.ViewModel(employeeList: response.employees)
                self.state = .success(viewModel)
            })
            .store(in: &cancellables)
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
