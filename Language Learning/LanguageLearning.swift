//
//  Language_LearningApp.swift
//  Language Learning
//
//  Created by TungDVS on 11/11/2023.
//

import SwiftUI

@main
struct LanguageLearning: App {
    
    @MainActor
    let chatViewModel = ChatViewModel(openAiService: ChatCompletionServiceImpl())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(chatViewModel)
                .environmentObject(TutorViewModel())
                .environmentObject(GeminiChatViewModel(geminiChatService: GeminiChatService()))
        }
    }
}
