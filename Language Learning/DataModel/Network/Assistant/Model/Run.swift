//
//  Run.swift
//  Language Learning
//
//  Created by TungDVS on 27/11/2023.
//

import Foundation

struct Run: Codable {
    let id: String
    let object: String
    let createdAt: Int
    let assistantId: String
    let threadId: String
    let status: RunStepStatus
    let startedAt: TimeInterval?
    let expiresAt: TimeInterval?
    let cancelledAt: TimeInterval?
    let failedAt: TimeInterval?
    let completedAt: TimeInterval?
    let lastError: String?
    let model: String?
    let instructions: String?
    let tools: [Tool]?
    let fileIds: [String]
    let requiredAction: RequiredAction?
    
    struct Tool: Codable {
        let type: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case createdAt = "created_at"
        case assistantId = "assistant_id"
        case threadId = "thread_id"
        case status
        case startedAt = "started_at"
        case expiresAt = "expires_at"
        case cancelledAt = "cancelled_at"
        case failedAt = "failed_at"
        case completedAt = "completed_at"
        case lastError = "last_error"
        case model
        case instructions
        case tools
        case fileIds = "file_ids"
        case requiredAction = "required_action"
    }
    
    enum RunStepStatus: String, Codable {
        case queued
        case inProgress = "in_progress"
        case requiresAction = "requires_action"
        case cancelling
        case cancelled
        case failed
        case completed
        case expired

        var statusStep: Int {
            switch self {
            case .queued:
                return 0
            case .inProgress:
                return 1
            case .requiresAction:
                return 2
            case .cancelling:
                return 3
            case .cancelled:
                return 4
            case .failed:
                return 5
            case .completed:
                return 6
            case .expired:
                return 7
            }
        }
    }
}

struct ThreadRunStep: Codable {
    let id: String
    let object: String
    let createdAt: Int
    let runId: String
    let assistantId: String
    let threadId: String
    let type: String
    let status: String
    let cancelledAt: Int?
    let completedAt: Int
    let expiredAt: Int?
    let failedAt: Int?
    let lastError: String?
    let stepDetails: StepDetail
}


struct StepDetail: Codable {
    
    // only use function now
    let toolsCalls: [SubmitToolOutput]
}

struct SubmitToolOutput: Codable {
    let toolCalls: [ToolCall]?

    enum CodingKeys: String, CodingKey {
        case toolCalls = "tool_calls"
    }
}

struct ToolCall: Codable {
    let id: String
    let type: ToolCallType
    let function: ToolCallFunction?
}

enum ToolCallType: String, Codable {
    case codeInterpreter
    case retrieval
    case function
}


struct ToolCallFunction: Codable {
    let name: String
    let arguments: String
//    let output: String?
}

struct RequiredAction: Codable {
    let submitToolOutputs: SubmitToolOutput? // only use function now
    
    enum CodingKeys: String, CodingKey {
        case submitToolOutputs = "submit_tool_outputs"
    }

    var function: ToolCallFunction? {
        return submitToolOutputs?.toolCalls?.first(where: {$0.type == .function })?.function
    }
    
    var quizFunctionToolCall: ToolCall? {
        return submitToolOutputs?.toolCalls?
            .first(where: {$0.type == .function && $0.function?.name == FunctionName.generateQuiz })
    }
    
    var quizFunction: ToolCallFunction? {
        return quizFunctionToolCall?.function
    }
    
    var quizFunctionId: String? {
        return quizFunctionToolCall?.id
    }
}

struct FunctionResponse: RequestBodyData {
    let toolOutputs: [ToolOutput]
}

struct ToolOutput: Codable {
    let toolCallId: String
    let output: String
}
