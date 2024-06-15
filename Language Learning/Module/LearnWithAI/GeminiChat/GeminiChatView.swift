//
//  GeminiChatView.swift
//  Language Learning
//
//  Created by TungDVS on 19/12/2023.
//

import SwiftUI

struct GeminiChatView: View {
    
    @EnvironmentObject var viewModel: GeminiChatViewModel
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                List {
                    ForEach(viewModel.chatContent) { message in
                        GeminiMessageRow(message: message)
                    }
                    .listRowSeparator(.hidden)
                    
                    if !viewModel.currentAssistanceMessage.isEmpty {
                        GeminiMessageRow(message: .init(modelContent: viewModel.currentAssistanceMessage))
                            .listRowSeparator(.hidden)
                            .id("MessageView")
                    }
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
                .onChange(of: viewModel.currentAssistanceMessage) { oldValue, newValue in
                    proxy.scrollTo("MessageView", anchor: .bottom)
                }
            }
            HStack(alignment: .center, spacing: 5) {
                TextField("Enter your message", text: $viewModel.currentMessage).textFieldStyle(RoundedBorderTextFieldStyle())
                Button("", systemImage: "paperplane.fill") {
                    Task {
                        try await viewModel.sendMessage()
                    }
                }.disabled(viewModel.disableSendButton)
                // a transparent grey background color
            }
            .backgroundStyle(Color.gray.opacity(0.2))
            .padding()
        }.onDisappear(perform: {
            viewModel.clearAllMessage()
        })
    }
}

#Preview {
    let viewModel = GeminiChatViewModel(geminiChatService: MockGoogleAIChatService())
    return GeminiChatView()
        .environmentObject(viewModel)
}
