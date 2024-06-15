//
//  OpenAIServiceMock.swift
//  Language Learning
//
//  Created by TungDVS on 11/11/2023.
//

import Foundation

class OpenAIServiceMock: ChatCompletionService {
    func getAnswer(messages: [Message], model: String) async throws -> AsyncThrowingStream<String, Error> {
        return AsyncThrowingStream<String, Error> { continuation in
             // Create a task that sends each letter of "Hello world part" every 0.5 seconds
             Task {
                 let phrase = "Hello world part"
                 for char in phrase {
                     // Check for cancellation
                     guard !Task.isCancelled else {
                         continuation.finish()
                         return
                     }
                     // Yield each character as a String
                     continuation.yield(String(char))
                     // Wait for 0.1 seconds before sending the next character
                     try await Task.sleep(nanoseconds: 100_000_000)
                 }
                 // Finish the stream after sending the last character
                 continuation.finish()
             }
         }
     }
}
