//
//  File.swift
//  
//
//  Copyright by iSoftStone 2023.
//

public struct EventsOverviewWrapper: Codable {
    public let events: [Event]
}

public struct Event: Codable {
    public let eventId: String?
    public let eventName: String?
    public let eventDescription: String?
    public let eventDate: EventDateDataModel?
    public let eventTime: EventTimeDataModel?
    public let eventDuration: String?
    public let eventRegistration: EventRegistrationDataModel?
    public let eventType: [EventTypeDataModel]?
    public let eventCategory: [EventCategoryDataModel]?
    public let eventTargetAudience: [EventTargetAudienceDataModel]?
    public let eventTermsAndConditions: String?
    public let eventFinePrint: String?
    public let eventPolicy: String?
    public let eventPrice: String?
    public let eventNumberOfTickets: String?
    public let eventStatus: String?
    public let eventCity: [String]?
    public let eventSpeakers: [EventSpeakerDataModel]?
    public let eventOrganizer: EventOrganizerDataModel?
    public let eventVenueInformation: EventVenueInformationDataModel?

    enum CodingKeys: String, CodingKey {
        case eventId = "_id"
        case eventName
        case eventDescription
        case eventDate
        case eventTime
        case eventDuration
        case eventRegistration
        case eventType
        case eventCategory
        case eventTargetAudience = "targetAudience"
        case eventTermsAndConditions = "termsAndConditions"
        case eventFinePrint = "finePrint"
        case eventPolicy = "policy"
        case eventPrice
        case eventNumberOfTickets = "numberOfTickets"
        case eventStatus = "status"
        case eventCity = "city"
        case eventSpeakers = "speakers"
        case eventOrganizer = "organizer"
        case eventVenueInformation = "venueInformation"
    }
}

public extension Event {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventId = try container.decodeIfPresent(String.self, forKey: .eventId) ?? ""
        eventName = try container.decodeIfPresent(String.self, forKey: .eventName) ?? ""
        eventDescription = try container.decodeIfPresent(String.self, forKey: .eventDescription) ?? ""
        eventDate = try container.decodeIfPresent(EventDateDataModel.self, forKey: .eventDate)
        eventTime = try container.decodeIfPresent(EventTimeDataModel.self, forKey: .eventTime)
        eventDuration = try container.decodeIfPresent(String.self, forKey: .eventDuration) ?? ""
        eventRegistration = try container.decodeIfPresent(EventRegistrationDataModel.self, forKey: .eventRegistration)
        eventType = try? container.decodeIfPresent([EventTypeDataModel].self, forKey: .eventType) ?? []
        eventCategory = try? container.decodeIfPresent([EventCategoryDataModel].self, forKey: .eventCategory) ?? []
        eventTargetAudience = try? container.decodeIfPresent([EventTargetAudienceDataModel].self, forKey: .eventTargetAudience) ?? []
        eventTermsAndConditions = try container.decodeIfPresent(String.self, forKey: .eventTermsAndConditions) ?? ""
        eventFinePrint = try container.decodeIfPresent(String.self, forKey: .eventFinePrint) ?? ""
        eventPolicy = try container.decodeIfPresent(String.self, forKey: .eventPolicy) ?? ""
        eventPrice = try container.decodeIfPresent(String.self, forKey: .eventPrice) ?? ""
        eventNumberOfTickets = try container.decodeIfPresent(String.self, forKey: .eventNumberOfTickets) ?? ""
        eventStatus = try container.decodeIfPresent(String.self, forKey: .eventStatus) ?? ""
        eventCity = try container.decodeIfPresent([String].self, forKey: .eventCity) ?? []
        eventSpeakers = try? container.decodeIfPresent([EventSpeakerDataModel].self, forKey: .eventSpeakers) ?? []
        eventOrganizer = try container.decodeIfPresent(EventOrganizerDataModel.self, forKey: .eventOrganizer)
        eventVenueInformation = try container.decodeIfPresent(EventVenueInformationDataModel.self, forKey: .eventVenueInformation)
    }
}


