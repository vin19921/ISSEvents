//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

public struct EventTargetAudienceDataModel: Codable {
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name
    }
}

public extension EventTargetAudienceDataModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
