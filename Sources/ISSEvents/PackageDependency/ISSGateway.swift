//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
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
}
