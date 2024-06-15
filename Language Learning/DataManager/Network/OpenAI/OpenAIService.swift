//
//  OpenAIService.swift
//  Language Learning
//
//  Created by TungDVS on 27/11/2023.
//

import Foundation

protocol OpenAIService {
    var baseURL: URL { get }
}

extension OpenAIService {
    var baseURL: URL {
        URL(string: "https://api.openai.com/v1")!
    }
}

protocol RequestBodyData: Codable {}
