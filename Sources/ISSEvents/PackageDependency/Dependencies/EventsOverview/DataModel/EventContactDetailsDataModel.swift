//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

struct EventContactDetailsDataModel: Codable {
    let contactType: String?
    let contact: String?

    enum CodingKeys: String, CodingKey {
        case contactType
        case contact
    }
}

extension EventContactDetailsDataModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        contactType = try container.decodeIfPresent(String.self, forKey: .contactType) ?? ""
        contact = try container.decodeIfPresent(String.self, forKey: .contact) ?? ""
    }
}
