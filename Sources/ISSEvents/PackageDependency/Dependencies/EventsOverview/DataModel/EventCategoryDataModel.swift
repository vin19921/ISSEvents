//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 22/06/2023.
//

public struct EventCategoryDataModel: Codable {
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name
    }
}

public extension EventCategoryDataModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
