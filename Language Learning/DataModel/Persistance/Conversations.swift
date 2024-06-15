//
//  Conversations.swift
//  Language Learning
//
//  Created by TungDVS on 26/11/2023.
//

import Foundation
import RealmSwift

class Conversations: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var messages: List<PersistedMessage>
}

class PersistedMessage: Object {
    @Persisted var time: TimeInterval
    @Persisted var role: Role
    @Persisted var content: String
}

