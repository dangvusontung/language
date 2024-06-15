//
//  ThreadServiceImpl.swift
//  Language Learning
//
//  Created by TungDVS on 26/11/2023.
//

import Foundation

class ThreadServiceImpl: BaseService, ThreadService {
    
    init(apiKeyManager: APIKeyManager = DebugAPIManager(), urlSession: URLSession = .shared) {
        super.init(apiKeyManager: apiKeyManager, urlSession: urlSession, betaAPI: true)
    }

    func createThread() async throws -> Thread {
        let path = "/threads"
        return try await create(path: path, body: nil)
    }
    
    func createMessage(threadId: String, content: String) async throws -> ThreadMessage {
        let path = "/threads/\(threadId)/messages"
        let message = Message(content: content)
        return try await create(path: path, body: message)
    }
    
    func retrieveThread(id: String) async throws -> Thread {
        let path = "/threads/\(id)"
        return try await retrieve(path: path)
    }
}
