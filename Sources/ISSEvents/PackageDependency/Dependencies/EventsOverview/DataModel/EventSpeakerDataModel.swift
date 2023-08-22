//
//  EventSpeakerDataModel.swift
//  
//
//  Copyright by iSoftStone 2023.
//

public struct EventSpeakerDataModel: Codable {
    let name: String?
    let bio: String?
    let photoUrl: String?

    enum CodingKeys: String, CodingKey {
        case name
        case bio
        case photoUrl
    }
}

public extension EventSpeakerDataModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        bio = try container.decodeIfPresent(String.self, forKey: .bio) ?? ""
        photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl) ?? ""
    }
}
