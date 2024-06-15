//
//  TutorViewModel.swift
//  Language Learning
//
//  Created by TungDVS on 14/11/2023.
//

import Foundation
import Combine

final class TutorViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let assistanceSessionManager: AssistanceSessionManager
    
    @Published var quiz: Quiz? = nil
    
    init(assistanceSessionManager: AssistanceSessionManager = AssistanceSessionManagerImpl()) {
        self.assistanceSessionManager = assistanceSessionManager
        
        $quiz.sink { quiz in
            print("Quiz = \(quiz)")
        }
        .store(in: &cancellables)
    
    }
    
    func getQuiz() {
        Task {
            do {
                let retrievedQuiz = try await assistanceSessionManager.createQuiz()
                await MainActor.run {
                    quiz = retrievedQuiz
                }
            } catch {
                print("error: \(error)")
            }
        }
    }
}
