//
//  OpenAIService.swift
//  Language Learning
//
//  Created by TungDVS on 11/11/2023.
//

import Foundation

protocol ChatCompletionService: OpenAIService {
    
    @discardableResult
    func getAnswer(messages: [Message], model: String) async throws -> AsyncThrowingStream<String, Error>
}

