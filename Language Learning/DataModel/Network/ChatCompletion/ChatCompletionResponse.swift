//
//  OpenAIChatCompletionResponse.swift
//  WordBank
//
//  Created by TungDVS on 07/11/2023.
//

import Foundation

struct OpenAIChatCompletionResponse: Decodable {
    let id: String
    let choices: [Choice]
    let created: TimeInterval
    let model: String
    let usage: Usage?
}

struct OpenAICompletionResponse: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
}

struct Choice: Decodable {
    let index: Int
    let delta: Delta
    let finishReason: String?
    
    enum CodingKeys: String, CodingKey {
        case index, delta
        case finishReason
    }
}

struct Delta: Decodable {
    let role: String?
    let content: String?
}

struct Usage: Decodable {
    var promptTokens: Int
    var completionTokens: Int
    var totalTokens: Int
}
