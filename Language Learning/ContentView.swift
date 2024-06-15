//
//  ContentView.swift
//  Language Learning
//
//  Created by TungDVS on 11/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var tutorViewModel: TutorViewModel
    @EnvironmentObject var geminiChatViewModel: GeminiChatViewModel
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    NavigationLink("Chat") {
                        ChatView()
                            .environmentObject(chatViewModel)
                    }
                    
                    NavigationLink("Grammar") {
                        EmptyView()
                    }
                    
                    NavigationLink("Translation") {
                        EmptyView()
                    }
                    
                    NavigationLink("Tutor") {
                        
                    }
                    
                    NavigationLink("Gemini") {
                        GeminiChatView()
                            .environmentObject(geminiChatViewModel)
                    }
                }
                    
            }
        }.onAppear {
//            tutorViewModel.getQuiz()
        }
    }
}

//#Preview {
//    ContentView()
//        .environmentObject(ChatViewModel(openAiService: OpenAIServiceMock()))
//        .environmentObject(TutorViewModel())
//}
