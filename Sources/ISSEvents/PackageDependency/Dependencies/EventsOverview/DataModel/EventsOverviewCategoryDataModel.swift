//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 22/06/2023.
//

struct EventsOverviewWrapper: Codable {
    let events: [EventsOverviewCategoryDataModel]
}

struct EventsOverviewCategoryDataModel: Codable {
    let eventId: String?
    let eventName: String?
    let eventDescription: String?
    let eventDate: EventDateDataModel?
    let eventTime: EventTimeDataModel?
    let eventDuration: String?
    let eventRegistration: EventRegistrationDataModel?
    let eventType: [EventTypeDataModel]?
    let eventCategory: [EventCategoryDataModel]?
    let eventTargetAudience: [EventTargetAudienceDataModel]?
    let eventTermsAndConditions: String?
    let eventFinePrint: String?
    let eventPolicy: String?
    let eventPrice: String?
    let eventNumberOfTickets: String?
    let eventStatus: String?
    let eventCity: [String]?
    let eventSpeakers: [EventSpeakerDataModel]?
    let eventOrganizer: EventOrganizerDataModel?
    let eventVenueInformation: EventVenueInformationDataModel?
    let createdBy: String?
    let createdDate: String?
    let modifiedBy: String?
    let modifiedDate: String?

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

extension EventsOverviewCategoryDataModel {
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

