//
//  EventContactPersonDataModel.swift
//  
//
//  Copyright by iSoftStone 2023.
//

struct EventContactPersonDataModel: Codable {
    let name: String?
    let contactDetails: [EventContactDetailsDataModel]?

    enum CodingKeys: String, CodingKey {
        case name
        case contactDetails
    }
}

extension EventContactPersonDataModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        contactDetails = try container.decodeIfPresent([EventContactDetailsDataModel].self, forKey: .contactDetails) ?? []
    }
}
