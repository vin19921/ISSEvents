//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

public struct Employee: Codable {
    public let id: Int
    public let employeeName: String
    public let employeeSalary: Int
    public let employeeAge: Int
    public let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}

public struct EmployeesResponse: Codable {
    public let status: String
    public let data: [Employee]
    public let message: String
}

public extension EmployeesResponse {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decode([Employee].self, forKey: .data)
    }
}
