//
//  RolePlay.swift
//  Language Learning
//
//  Created by TungDVS on 12/11/2023.
//

import Foundation
import RealmSwift

enum RolePlay: String, PersistableEnum {
    case tutor
    case orderingAtCafe
    case groceryShopping
    case askingForDirections
    case makingHotelReservation
    case introducingYourself
    // ... add other beginner level scenarios
    
    case doctorsAppointment
    case jobInterview
    case planningATrip
    case diningOut
    case attendingAClass
    // ... add other intermediate level scenarios
    
    case debateOnSocialIssues
    case businessMeeting
    case narratingAStory
    case rentingOrBuyingHouse
    case culturalExchange
    // ... add other advanced level scenarios
    
    case parentTeacherMeeting
    case emergencySituations
    case theatreBooking
    case fitnessClass
    case cookingClass
    // ... add other specialized scenarios
}

extension RolePlay {
    
    var systemMessage: Message {
        return Message(role: .system, content: "Act as a \(assistanceRole) with context of \(promptString)")
    }

    var assistanceRole: String {
        switch self {
        case .tutor:
            return "tutor"
        case .orderingAtCafe:
            return "waiter"
        case .groceryShopping:
            return "shop assistant"
        case .askingForDirections:
            return "local resident"
        case .makingHotelReservation:
            return "hotel receptionist"
        case .introducingYourself:
            return "new acquaintance"
        case .doctorsAppointment:
            return "doctor"
        case .jobInterview:
            return "interviewer"
        case .planningATrip:
            return "travel agent"
        case .diningOut:
            return "restaurant server"
        case .attendingAClass:
            return "teacher"
        case .debateOnSocialIssues:
            return "debate opponent"
        case .businessMeeting:
            return "business colleague"
        case .narratingAStory:
            return "listener"
        case .rentingOrBuyingHouse:
            return "real estate agent"
        case .culturalExchange:
            return "cultural ambassador"
        case .parentTeacherMeeting:
            return "teacher"
        case .emergencySituations:
            return "emergency responder"
        case .theatreBooking:
            return "ticket seller"
        case .fitnessClass:
            return "fitness trainer"
        case .cookingClass:
            return "cooking instructor"
        }
    }
    
    var promptString: String {
        switch self {
        case .tutor:
            return "in a private class"
        case .orderingAtCafe:
            return "ordering at Cafe"
        case .groceryShopping:
            return "grocery shopping"
        case .askingForDirections:
            return "asking for directions"
        case .makingHotelReservation:
            return "making hotel reservation"
        case .introducingYourself:
            return "introducing yourself"
        case .doctorsAppointment:
            return "doctor's appointment"
        case .jobInterview:
            return "job interview"
        case .planningATrip:
            return "planning a trip"
        case .diningOut:
            return "dining out"
        case .attendingAClass:
            return "attending a class"
        case .debateOnSocialIssues:
            return "debate on social issues"
        case .businessMeeting:
            return "business meeting"
        case .narratingAStory:
            return "narrating a story"
        case .rentingOrBuyingHouse:
            return "renting or buying a house"
        case .culturalExchange:
            return "cultural exchange"
        case .parentTeacherMeeting:
            return "parent-teacher meeting"
        case .emergencySituations:
            return "emergency situations"
        case .theatreBooking:
            return "theatre booking"
        case .fitnessClass:
            return "fitness class"
        case .cookingClass:
            return "cooking class"
        }
    }
}


