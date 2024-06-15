//
//  BaseChatViewModel.swift
//  Language Learning
//
//  Created by TungDVS on 14/11/2023.
//

import Foundation
import Combine

class BaseChatViewModel: ObservableObject {
    private var currentModel = GPTModel.gpt4turbo
    
//    private let systemMessage: Message
    
    @Published var hideSelectModelView = false
    @Published private(set) var currentAssistanceMessage = ""
    @Published var currentMessage = ""
    @Published var disableSendButton = false
    @Published var displayMessages: [Message] = []
    
    private(set) var cancellables: Set<AnyCancellable> = []
    
    var rolePlay: RolePlay?
    
    private let openAiService: ChatCompletionService
    
    init(openAiService: ChatCompletionService) {
        self.openAiService = openAiService
        self.rolePlay = nil
    }
    
    func sendMessage() async throws {
        
        await MainActor.run {
            if !hideSelectModelView {
                hideSelectModelView = true
            }
        }
        do {
            await updateMessageToSend()
            
            let roleDefineMessage = rolePlay?.systemMessage
            
            let sendMessages: [Message]
            if let roleDefineMessage = roleDefineMessage {
                sendMessages = [roleDefineMessage] + displayMessages
            } else {
                sendMessages = displayMessages
            }
            let stream = try await openAiService.getAnswer(messages: sendMessages, model: currentModel.rawValue)
            
            for try await newMessageContent in stream {
                await MainActor.run {
                    currentAssistanceMessage = newMessageContent
                }
            }
            
            await MainActor.run {
                let message = Message(role: .assistant, content: currentAssistanceMessage)
                currentAssistanceMessage = ""
                displayMessages.append(message)
                handleCompleteStream()
            }
            
        } catch {
            print("Error = \(error)")
            await handleCompleteStream()
        }
        
    }
    
    @MainActor
    private func updateMessageToSend() {
        let messageToSend = currentMessage
        currentMessage = ""
        let userMessage = Message(role: .user, content: messageToSend)
        displayMessages.append(userMessage)
        disableSendButton = true
    }
    
    @MainActor
    private func handleCompleteStream() {
        disableSendButton = false
    }

    func clearAllMesssages() {
        displayMessages = []
        currentAssistanceMessage = ""
        currentMessage = ""
    }
}
