//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

public struct EventVenueInformationDataModel: Codable {
    let venueType: String?
    let unit: String?
    let address: String?
    let city: String?
    let state: String?
    let contactPerson: [EventContactPersonDataModel]?
    let status: String?
    let capacity: Int32?
    let amenities: [String]?

    enum CodingKeys: String, CodingKey {
        case venueType
        case unit
        case address
        case city
        case state
        case contactPerson
        case status
        case capacity
        case amenities
    }
}

public extension EventVenueInformationDataModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        venueType = try container.decodeIfPresent(String.self, forKey: .venueType) ?? ""
        unit = try container.decodeIfPresent(String.self, forKey: .unit) ?? ""
        address = try container.decodeIfPresent(String.self, forKey: .address) ?? ""
        city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
        contactPerson = try container.decodeIfPresent([EventContactPersonDataModel].self, forKey: .contactPerson) ?? []
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        capacity = try container.decodeIfPresent(Int32.self, forKey: .capacity) ?? 0
        amenities = try container.decodeIfPresent([String].self, forKey: .amenities) ?? []
    }
}
