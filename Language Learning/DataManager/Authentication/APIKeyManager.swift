//
//  APIKeyManager.swift
//  Language Learning
//
//  Created by TungDVS on 11/11/2023.
//

import Foundation

protocol APIKeyManager {
    func getAPIKey() -> String
}

class DebugAPIManager: APIKeyManager {
    func getAPIKey() -> String {
        return ""
    }
}

class GoogleAPIManager: APIKeyManager {
    func getAPIKey() -> String {
        return ""
    }
}
