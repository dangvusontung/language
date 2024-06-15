//
//  GoogleAIChatService.swift
//  Language Learning
//
//  Created by TungDVS on 31/12/2023.
//

import Foundation
import GoogleGenerativeAI

protocol GoogleAIChatService {
    
    @discardableResult
    func generate(messageContent: String) async throws -> AsyncThrowingStream<GenerateContentResponse, Error>
}

class MockGoogleAIChatService: GoogleAIChatService {
    
    @discardableResult
    func generate(messageContent: String) async throws -> AsyncThrowingStream<GenerateContentResponse, Error> {
        let stream = AsyncThrowingStream<GenerateContentResponse, Error> { continuation in
            continuation.yield(GenerateContentResponse.init(candidates: [], promptFeedback: nil))
        }
        return stream
    }
}
