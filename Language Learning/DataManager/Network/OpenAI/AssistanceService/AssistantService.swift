//
//  AssistantService.swift
//  Language Learning
//
//  Created by TungDVS on 26/11/2023.
//

import Foundation

protocol AssistantService: OpenAIService {
    func getAssistance() async throws -> ([Assistant], Error?)
}

protocol MessageService: OpenAIService {
    func createMessage(threadId: String, role: Role, content: String, fileIds: [String]?) async throws -> (ThreadMessage?, Error?)
    
}
