//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 22/06/2023.
//

public struct EventOrganizerDataModel: Codable {
    let company: String?
    let contactPerson: [EventContactPersonDataModel]?

    enum CodingKeys: String, CodingKey {
        case company
        case contactPerson
    }
}

public extension EventOrganizerDataModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        company = try container.decodeIfPresent(String.self, forKey: .company) ?? ""
        contactPerson = try container.decodeIfPresent([EventContactPersonDataModel].self, forKey: .contactPerson) ?? []
    }
}
