//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 20/06/2023.
//

import Foundation

protocol RoutingLogic {
    associatedtype Destination
    func navigate(to destination: Destination)
}
