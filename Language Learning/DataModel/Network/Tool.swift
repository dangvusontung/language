//
//  Tool.swift
//  Language Learning
//
//  Created by TungDVS on 27/11/2023.
//

import Foundation

enum ToolType: Codable {
    case codeInterpreter
    case retrieval
    case function
    
    var type: String {
        switch self {
        case .codeInterpreter:
            return "code_interpreter"
        case .retrieval:
            return "retrieval"
        case .function:
            return "function"
        }
    }
}

struct Function: Codable {
    var name: String
    var description: String
    var parameters: [String: String]
}
