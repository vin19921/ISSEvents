//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import Foundation

protocol RoutingLogic {
    associatedtype Destination
    func navigate(to destination: Destination)
}
