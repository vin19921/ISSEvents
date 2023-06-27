//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 27/06/2023.
//

public struct Employee: Codable {
    let id: Int
    let employeeName: String
    let employeeSalary: Int
    let employeeAge: Int
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}

public struct EmployeesResponse: Codable {
    let status: String
    let data: [Employee]
    let message: String
}

public extension EmployeesResponse {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decode([Employee].self, forKey: .data)
    }
}
