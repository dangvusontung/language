//
//  AssistanceSessionManager.swift
//  Language Learning
//
//  Created by TungDVS on 28/11/2023.
//

import Foundation
import Combine

protocol AssistanceSessionManager {
    func createQuiz() async throws -> Quiz?
}

class AssistanceSessionManagerImpl: AssistanceSessionManager, ObservableObject {
    
    func createQuiz() async throws -> Quiz? {
        if let thread = try await createThread(), let _ = try await createMessage(threadId: thread.id, content: quizContent) {
            let quiz = try await createRunAndStartWatchingRunStatus(thread: thread)
            return quiz
        }
        return nil
    }
    
    private let threadService: ThreadService
    private let runService: RunService
    
    private let assistanceId = "asst_Ai8UwSbhszYUdXESKgLlyISW"
    
    @Published var quizContent: String = "A1 quiz"
    
    init(threadService: ThreadService = ThreadServiceImpl(),
        runService: RunService = RunServiceImpl()) {
        self.threadService = threadService
        self.runService = runService
    }
    
    func createThread() async throws -> (Thread?) {
        return try await threadService.createThread()
    }
    
    func createMessage(threadId: String, content: String) async throws -> (ThreadMessage?) {
        return try await threadService.createMessage(threadId: threadId, content: content)
    }
    
    func createRunAndStartWatchingRunStatus(thread: Thread) async throws -> Quiz? {
        let run = try await runService.createRun(threadId: thread.id, assistantId: assistanceId)
        var status = run.status
        
        repeat {
            // delay 0.5 seconds
            try await Task.sleep(nanoseconds: 500_000_000)
            if let run = try await watchRunStatus(threadId: thread.id, runId: run.id) {
                status = run.status
                if status == .requiresAction {
                    return try extractQuizFromRun(run: run)
                }
            } else {
                return nil
            }
        } while (status == .queued || status == .inProgress)
        
        return nil
    }
    
    private func watchRunStatus(threadId: String, runId: String) async throws -> Run? {
        return try await runService.retrieveRun(threadId: threadId, runId: runId)
    }
    
    private func extractQuizFromRun(run: Run) throws -> Quiz? {
        if let id = run.requiredAction?.quizFunctionId, let arguments = run.requiredAction?.quizFunction?.arguments {
            let data = Data(arguments.utf8)
            // Decode Quiz list from data
            do {
                let quizList = try parseQuiz(from: data)
                let toolOutput = ToolOutput(toolCallId: id, output: "success: true")
                submitToolOutput(threadId: run.threadId, runId: run.id, toolsOutput: [toolOutput])
                return quizList
            } catch {
                print("Decode quiz error: \(error)")
            }
        }
        return nil
    }
    
    private func submitToolOutput(threadId: String, runId: String, toolsOutput: [ToolOutput]) {
        Task {
            do {
                let run = try await runService.submitToolOutputForRun(threadId: threadId, runId: runId, toolOutputs: toolsOutput)
                handleFinalRun(run: run)
            } catch {
                print("error = \(error)")
            }
        }
    }
    
    private func handleFinalRun(run: Run?) {
        guard let run = run else {
            return
        }
        print("Submit function result success. runId = \(run.id)")
        print(run)
    }
    
    // Function to parse the Quiz JSON data into a Quiz object
    private func parseQuiz(from jsonData: Data) throws -> Quiz {
        do {
            let quiz = try JSONDecoder().decode(Quiz.self, from: jsonData)
            return quiz
        } catch {
            throw error
            
        }
    }
}
