//
//  RunServiceImpl.swift
//  Language Learning
//
//  Created by TungDVS on 29/11/2023.
//

import Foundation

final class RunServiceImpl: BaseService, RunService {
    
    init(apiKeyManager: APIKeyManager = DebugAPIManager(), urlSession: URLSession = .shared) {
        super.init(apiKeyManager: apiKeyManager, urlSession: urlSession, betaAPI: true)
    }
    
    func createRun(threadId: String, assistantId: String) async throws -> Run {
        let path = "threads/\(threadId)/runs"
        let body = CreateRunRequest(assistantId: assistantId)
        return try await create(path: path, body: body)
    }
    
    func retrieveRun(threadId: String, runId: String) async throws -> Run {
        let path = "threads/\(threadId)/runs/\(runId)"
        return try await retrieve(path: path)
    }
    
    @discardableResult func submitToolOutputForRun(threadId: String, runId: String, toolOutputs: [ToolOutput]) async throws -> Run {
        
        let path = "threads/\(threadId)/runs/\(runId)/submit_tool_outputs"
        let functionResponse = FunctionResponse(toolOutputs: toolOutputs)
        return try await create(path: path, body: functionResponse)
        
    }
    
    func retrieveRunStep(threadId: String, runId: String, stepId: String) async throws -> ThreadRunStep {
        fatalError("Not implemented")
    }
}


