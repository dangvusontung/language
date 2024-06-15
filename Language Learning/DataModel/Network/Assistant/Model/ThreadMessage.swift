//
//  ThreadMessage.swift
//  Language Learning
//
//  Created by TungDVS on 27/11/2023.
//

import Foundation

struct ThreadMessage: Codable {
    var id: String?
    var createdAt: TimeInterval?
    var threadId: String?
    var role: Role?
    var assistantId: String?
    var runId: String?
    var fileIds: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case threadId = "thread_id"
        case role
        case assistantId = "assistant_id"
        case runId = "run_id"
        case fileIds = "file_ids"
        
    }
}

struct CreateRunRequest: RequestBodyData {
    var assistantId: String
    
    enum CodingKeys: String, CodingKey {
        case assistantId = "assistant_id"
    }
}
