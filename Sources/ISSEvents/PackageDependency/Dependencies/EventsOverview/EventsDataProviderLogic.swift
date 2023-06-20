//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
//


import Combine

/// The events provider facilitate communication between the controller from the UI layer and the services that are used to retrieve/persist data.
/// This helps provide proper separation of concerns between the these objects.
public protocol EventsDataProviderLogic {
}

/// DataFetchTypes helps the service to send send data based on different CachePolicies.
public enum EventsDataFetchType {
    /// InitialLoad, Refresh can be responsible of taking data by calling actual api.
    case initialLoad, refresh
    /// Preview shall be responsible to fetch data from Cache itself without calling actual api.
    case preview
}
