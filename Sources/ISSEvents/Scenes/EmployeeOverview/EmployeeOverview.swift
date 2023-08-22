//
//  EmployeeOverview.swift
//  
//
//  Copyright by iSoftStone 2023.
//

import Foundation

enum EmployeeOverview {
    
    enum Model {
        struct Request {
            // Request
        }
        
        struct Response {
            var status: String
            var employees: [Employee]
            var message: String
        }

        public struct ViewModel {
            var employeeList: [Employee]
        }
    }
}

