//
//  Thread.swift
//  Language Learning
//
//  Created by TungDVS on 26/11/2023.
//

import Foundation

struct Thread: Codable {
    let id: String
    let object: String
    let createdAt: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case createdAt = "created_at"
    }
}
