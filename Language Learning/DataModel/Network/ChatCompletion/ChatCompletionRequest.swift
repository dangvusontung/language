//
//  APIMessage.swift
//  Language Learning
//
//  Created by TungDVS on 11/11/2023.
//

import Foundation
import RealmSwift

struct Message: RequestBodyData, Identifiable {
    var id = Date().timeIntervalSince1970
    var role: Role
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case role
        case content
    }
}

extension Message {
    init(content: String) {
        self.role = .user
        self.content = content
    }
}

enum Role: String, Codable, PersistableEnum {
    case system
    case user
    case assistant
}

enum GPTModel: String, Codable, CaseIterable, Identifiable {
    case gpt35turbo = "gpt-3.5-turbo"
    case gpt4 = "gpt-4"
    case gpt4turbo = "gpt-4-1106-preview"
    
    var id: String {
        return rawValue
    }
}

struct ChatCompletionRequest: Encodable {
    let model: GPTModel
    let messages: [Message]
    let stream: Bool
    
    init(model: GPTModel = .gpt35turbo, messages: [Message]) {
        self.model = model
        self.messages = messages
        self.stream = true
    }
}


