//
//  MessageRow.swift
//  Language Learning
//
//  Created by TungDVS on 11/11/2023.
//

import SwiftUI

struct MessageRow: View {
    
    var message: Message
    
    var body: some View {
        VStack {
            Text(message.role.title)
                .foregroundStyle(message.role.backgroundColor)
                .font(.subheadline)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
            
            Text(.init(message.content))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.horizontal)
    }
}

#Preview {
    let message = Message(role: .assistant, content: "Hello how can i assist you today?")
    return MessageRow(message: message)
}

extension Role {
    var iconName: String {
        switch self {
        case .system:
            return "robot"
        case .user:
            return "person"
        case .assistant:
            return "person.2"
        }
    }
    
    var title: String {
        switch self {
        case .system:
            return ""
        case .user:
            return "You"
        case .assistant:
            return "ChatGPT"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .system:
            return .red
        case .user:
            return .green
        case .assistant:
            return .accentColor
        }
    }
}
