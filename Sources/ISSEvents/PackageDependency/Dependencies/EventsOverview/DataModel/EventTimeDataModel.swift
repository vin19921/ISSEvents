//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 22/06/2023.
//

struct EventTimeDataModel: Codable {
    let start: String?
    let end: String?

    enum CodingKeys: String, CodingKey {
        case start
        case end
    }
}

extension EventTimeDataModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        start = try container.decodeIfPresent(String.self, forKey: .start) ?? ""
        end = try container.decodeIfPresent(String.self, forKey: .end) ?? ""
    }
}
