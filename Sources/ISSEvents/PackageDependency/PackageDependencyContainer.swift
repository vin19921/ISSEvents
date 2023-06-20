//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
//

/// All dependencies that are required to be initialized once and passed down to the providers should be held here.
public struct PackageDependencyContainer {
    public var eventsOverviewProvider: EventsDataProviderLogic?
    public var eventsOverviewRouter: EventsRoutingLogic?
}

public enum PackageDependency {
    public static var dependencies: PackageDependencyContainer? {
        return packageDependencies
    }
    
    private static var packageDependencies: PackageDependencyContainer = PackageDependencyContainer()
    
    public static func setEventsOverviewProvider(provider: EventsDataProviderLogic) {
        packageDependencies.eventsOverviewProvider = provider
    }
    
    public static func setEventsOverviewRouter(router: EventsRoutingLogic) {
        packageDependencies.eventsOverviewRouter = router
    }
}
