//
//  Assistant.swift
//  Language Learning
//
//  Created by TungDVS on 26/11/2023.
//

import Foundation

struct Assistant: Codable {
    let id: String
    let object = "assistant"
    let createdAt: TimeInterval
    let name: String
    let description: String
    let model: [GPTModel] = [.gpt4turbo]
    let instructions: String
    let fileIds: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name
        case description
        case instructions
        case fileIds = "file_ids"
    }
}
