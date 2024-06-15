//
//  ChatView.swift
//  Language Learning
//
//  Created by TungDVS on 11/11/2023.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    var body: some View {
        VStack {
//            if !chatViewModel.hideSelectModelView {
//                Picker("", selection: $chatViewModel.currentModel) {
//                    ForEach(GPTModel.allCases) { model in
//                        Text(model.rawValue)
//                            .tag(model)
//                    }
//                }
//            }
            ScrollViewReader { proxy in
                List {
                    ForEach(chatViewModel.displayMessages) { message in
                        MessageRow(message: message)
                    }
                    .listRowSeparator(.hidden)
                    if !chatViewModel.currentAssistanceMessage.isEmpty { 
                        MessageRow(message: .init(role: .assistant, content: chatViewModel.currentAssistanceMessage))
                            .listRowSeparator(.hidden)
                            .id("ChatView")
                    }
                    
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
                .onChange(of: chatViewModel.currentAssistanceMessage) { oldValue, newValue in
                    proxy.scrollTo("ChatView", anchor: .bottom)
                }
            }
            HStack(alignment: .center, spacing: 5) {
                TextField("Enter your message", text: $chatViewModel.currentMessage)
                Button("", systemImage: "paperplane.fill") {
                    Task {
                        try await chatViewModel.sendMessage()
                    }
                }.disabled(chatViewModel.disableSendButton)
                // a transparent grey background color
            }
            .backgroundStyle(Color.gray.opacity(0.2))
            .padding()
        }.onDisappear(perform: {
            chatViewModel.clearAllMesssages()
        })
    }
}

#Preview {
    let viewModel = ChatViewModel(openAiService: OpenAIServiceMock())
    return ChatView()
        .environmentObject(viewModel)
}

