//
//  ThreadService.swift
//  Language Learning
//
//  Created by TungDVS on 27/11/2023.
//

import Foundation

protocol ThreadService: OpenAIService {
    func createThread() async throws -> Thread
    func createMessage(threadId: String, content: String) async throws -> ThreadMessage
    func retrieveThread(id: String) async throws -> Thread
    
}
