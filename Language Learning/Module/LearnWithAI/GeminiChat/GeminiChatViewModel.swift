//
//  GeminiChatViewModel.swift
//  Language Learning
//
//  Created by TungDVS on 18/12/2023.
//

import Foundation
import GoogleGenerativeAI

class GeminiChatViewModel: ObservableObject {
    
    private let geminiChatService: GoogleAIChatService
    
    @Published var currentMessage = ""
    @Published var currentAssistanceMessage: String = ""
    
    @Published var chatContent: [GeminiChatMessage] = []
    @Published var disableSendButton = false
    
    init(geminiChatService: GoogleAIChatService) {
        self.geminiChatService = geminiChatService
    }
    
    func sendMessage() async throws {
        let message = currentMessage
        
        await MainActor.run {
            currentMessage = ""
            chatContent.append(GeminiChatMessage(userContent: message))
            disableSendButton = true
        }
        
        do {
            
            let history = chatContent.map { $0.toModelContent() }
            
            let stream = try await geminiChatService.generate(messageContent: message)
            
            for try await chunk in stream {
                if let text = chunk.text {
                    await updateCurrentLastMessage(content: text)
                }
            }
            
            await handleCompletedStream()
        } catch {
            print("Error = \(error)")
            await handleCompletedStream()
        }
    }
    
    @MainActor
    private func updateCurrentLastMessage(content: String) {
        print("content = \(content)")
        currentAssistanceMessage += content
    }
    
    @MainActor
    private func resetCurrentUserMessage() {
        currentMessage = ""
    }
    
    @MainActor
    private func handleCompletedStream() {
        let lastMessageContent = currentAssistanceMessage
        currentAssistanceMessage = ""
        let lastMessage = GeminiChatMessage(modelContent: lastMessageContent)
        chatContent.append(lastMessage)
        disableSendButton = false
    }
    
    func clearAllMessage() {
        chatContent = []
        currentMessage = ""
        currentAssistanceMessage = ""
        
    }
}

import RealmSwift
enum GoogleGeminiChatRole: String, PersistableEnum {
    case user
    case model
    case unknown
}

import SwiftUI
extension GoogleGeminiChatRole {
    var title: String {
        switch self {
        case .user:
            return "You"
        case .model:
            return "Gemini"
        default:
            return ""
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .model:
            return .red
        case .user:
            return .green
        default:
            return .accentColor
        }
    }
}

struct GeminiChatMessage: Identifiable{
    var id: String
    var role: GoogleGeminiChatRole
    var content: String
}

extension GeminiChatMessage {
    init(modelContent: ModelContent) {
        self.id = UUID().uuidString
        self.content = modelContent.parts.compactMap(\.text).joined()
        if let role = modelContent.role {
            self.role = GoogleGeminiChatRole(rawValue: role) ?? .unknown
        } else {
            self.role = .unknown
        }
    }
    
    init(modelContent: String) {
        self.id = UUID().uuidString
        self.role = .model
        self.content = modelContent
    }
    
    init(userContent: String) {
        self.id = UUID().uuidString
        self.role = .user
        self.content = userContent
    }
    
    // to modelContent
    func toModelContent() -> ModelContent {
        return ModelContent(role: self.role.rawValue , self.content)
    }
}
