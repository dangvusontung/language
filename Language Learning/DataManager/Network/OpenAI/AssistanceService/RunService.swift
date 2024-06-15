//
//  RunService.swift
//  Language Learning
//
//  Created by TungDVS on 27/11/2023.
//

import Foundation

protocol RunService: OpenAIService {
    func createRun(threadId: String, assistantId: String) async throws -> Run
    func retrieveRun(threadId: String, runId: String) async throws -> Run
    func retrieveRunStep(threadId: String, runId: String, stepId: String) async throws -> ThreadRunStep
    @discardableResult func submitToolOutputForRun(threadId: String, runId: String, toolOutputs: [ToolOutput]) async throws -> Run
}

