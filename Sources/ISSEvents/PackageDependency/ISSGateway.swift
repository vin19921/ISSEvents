//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import ISSTheme
import Foundation

/// The ISSGateway facilitate creation of EventsOverview Screen with injection of dependencies from the app
/// This helps provide proper separation of concerns between app and events package.
public enum ISSGateway {
    /// creates EventsOverview after getting all dependencies from the app.
    /// - Parameters:
    ///     - theme:  refer to ThemeKit:
    ///     - provider:  refer to EventsDataProviderLogic documentation
    ///     - router:  refer to EventsRoutingLogic documentation
    public static func makeEventsOverview(theme: Theme,
                                          provider: EventsDataProviderLogic,
                                          router: EventsRoutingLogic) ->
    EventsOverviewView
    {
        /// Explicity setting the theme to register fonts and colors required by events package.
        Theme.current = theme
        injectEventsOverviewProvider(provider)
        injectEventsOverviewRouter(router)
        
        let interactor = EventsOverviewInteractor(provider: provider)
        let presenter = EventsOverviewPresenter(interactor: interactor)
        
        let view = EventsOverviewView(presenter: presenter)
        let eventsOverviewRouter = EventsOverviewRouter(navigator: router)
        
        presenter.setRouter(eventsOverviewRouter)
        return view
    }

    private static func injectEventsOverviewProvider(_ provider: EventsDataProviderLogic) {
        let internalDepends = PackageDependency.self
        internalDepends.setEventsOverviewProvider(provider: provider)
    }

    private static func injectEventsOverviewRouter(_ router: EventsRoutingLogic) {
        let internalDepends = PackageDependency.self
        internalDepends.setEventsOverviewRouter(router: router)
    }

    private static func injectEventsCheckOutRouter(_ router: EventsCheckOutRoutingLogic) {
        let internalDepends = PackageDependency.self
        internalDepends.setEventsCheckOutRouter(router: router)
    }

    /// creates EventsOverview after getting all dependencies from the app.
    /// - Parameters:
    ///     - theme:  refer to ThemeKit:
    ///     - provider:  refer to EventsDataProviderLogic documentation
    ///     - router:  refer to EventsRoutingLogic documentation
    public static func makeEventsSearch(
//                                        provider: EventsDataProviderLogic,
                                        router: EventsSearchRoutingLogic
    ) ->
    EventsSearchView
    {
        /// Explicity setting the theme to register fonts and colors required by events package.
//        Theme.current = theme
//        injectEventsOverviewProvider(provider)
//        injectEventsOverviewRouter(router)
        
//        let interactor = EventsOverviewInteractor(provider: provider)
        let presenter = EventsSearchPresenter()
        
        let view = EventsSearchView(presenter: presenter)
        let eventsSearchRouter = EventsSearchRouter(navigator: router)
        
        presenter.setRouter(eventsSearchRouter)
        return view
    }

    public static func makeEventsCheckOut(
//                                        provider: EventsDataProviderLogic,
                                        router: EventsCheckOutRoutingLogic
    ) ->
    EventsCheckOutView
    {
        injectEventsCheckOutRouter(router)
        let presenter = EventsCheckOutPresenter()
        
        let view = EventsCheckOutView(presenter: presenter)
        let eventsCheckOutRouter = EventsCheckOutRouter(navigator: router)
        
        presenter.setRouter(eventsCheckOutRouter)
        return view
    }

    public static func makeEventsPromoCode() -> EventsPromoCodeView {
        let presenter = EventsPromoCodePresenter()
//        let viewModel = PromoCodeViewModel()
        
        let view = EventsPromoCodeView(presenter: presenter
//                                       ,
//                                       viewModel: viewModel
        )
        return view
    }

    public static func makeEventsPayment() -> EventsPaymentView {
        let presenter = EventsPaymentPresenter()
//        let viewModel = PromoCodeViewModel()
        
        let view = EventsPaymentView(presenter: presenter
//                                       ,
//                                       viewModel: viewModel
        )
        return view
    }

    public static func makeEventsDetail(
//                                        provider: EventsDataProviderLogic,
//                                        router: EventsCheckOutRoutingLogic
    ) ->
    EventsDetailView
    {
//        injectEventsCheckOutRouter(router)
        let presenter = EventsDetailPresenter()
        
        let view = EventsDetailView(presenter: presenter)
//        let eventsCheckOutRouter = EventsCheckOutRouter(navigator: router)
        
//        presenter.setRouter(eventsCheckOutRouter)
        return view
    }
}
