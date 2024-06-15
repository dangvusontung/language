//
//  GeminiMessageRow.swift
//  Language Learning
//
//  Created by TungDVS on 24/12/2023.
//

import SwiftUI

struct GeminiMessageRow: View {
    
    let message: GeminiChatMessage
    
    @State var showCopyOptions = false
     
    var body: some View {
        VStack(alignment: .leading) {
            Text(message.role.title)
                .foregroundStyle(message.role.backgroundColor)
            Text(.init(message.content))
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    let message = GeminiChatMessage(userContent: "Hello")
    return GeminiMessageRow(message: message)
}
