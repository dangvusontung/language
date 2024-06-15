//
//  GoogleChatConversation.swift
//  Language Learning
//
//  Created by TungDVS on 31/12/2023.
//

import Foundation
import RealmSwift
import GoogleGenerativeAI

class GoogleChatConversation: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var lastModified: TimeInterval
    @Persisted var title: String
    @Persisted var messages: List<PersistedGoogleMessage>
}

extension GoogleChatConversation {
    convenience init(id: String = UUID().uuidString, title: String, messages: [PersistedGoogleMessage]) {
        self.init()
        self.id = id
        self.title = title
        self.messages.append(objectsIn: messages)
    }
    
    convenience init(chat: Chat) {
        self.init()
        self.id = UUID().uuidString
        self.messages.append(objectsIn:  chat.history.map(PersistedGoogleMessage.init))
    }
}

class PersistedGoogleMessage: Object {
    @Persisted var role: GoogleGeminiChatRole
    @Persisted var content: String
}

extension PersistedGoogleMessage {
    convenience init(role: GoogleGeminiChatRole, content: String) {
        self.init()
        self.role = role
        self.content = content
    }
    
    convenience init(geminiMessage: GeminiChatMessage) {
        self.init()
        self.role = geminiMessage.role
        self.content = geminiMessage.content
    }
}
