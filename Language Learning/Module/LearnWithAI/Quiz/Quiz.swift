//
//  Quiz.swift
//  Language Learning
//
//  Created by TungDVS on 27/11/2023.
//

import Foundation

struct Quiz: Codable {
    let title: String
    let questions: [Question]
}

struct Question: Codable {
    let questionId: String
    let questionText: String
    let correctAnswer: String
    let choices: [QuizChoice]
    
    enum CodingKeys: String, CodingKey {
        case questionId = "question_id"
        case questionText = "question_text"
        case correctAnswer = "correct_answer"
        case choices
    }
}

struct QuizChoice: Codable, Identifiable {
    var id = UUID().uuidString
    let choice: String
    let answer: String

    enum CodingKeys: String, CodingKey {
        case choice
        case answer
    }
}

extension Question: Identifiable {
    var id: String {
        questionId
    }
    static let preview: Question = Quiz.previewQuiz.questions[0]
}

// preview quiz
extension Quiz {
    static let previewQuiz = Quiz(title: "Quiz 1", questions: [
        Question(questionId: "1", questionText: "What is the capital of Vietnam?", correctAnswer: "Hanoi", choices: [
            QuizChoice(choice: "A", answer: "Hanoi"),
            QuizChoice(choice: "B", answer: "Ho Chi Minh"),
            QuizChoice(choice: "C", answer: "Da Nang"),
            QuizChoice(choice: "D", answer: "Hue")
        ]),
        Question(questionId: "2", questionText: "What is the capital of Japan?", correctAnswer: "Tokyo", choices: [
            QuizChoice(choice: "A", answer: "Tokyo"),
            QuizChoice(choice: "B", answer: "Osaka"),
            QuizChoice(choice: "C", answer: "Kyoto"),
            QuizChoice(choice: "D", answer: "Hokkaido")
        ]),
        Question(questionId: "3", questionText: "What is the capital of South Korea?", correctAnswer: "Seoul", choices: [
            QuizChoice(choice: "A", answer: "Seoul"),
            QuizChoice(choice: "B", answer: "Busan"),
            QuizChoice(choice: "C", answer: "Daegu"),
            QuizChoice(choice: "D", answer: "Jeju")
        ]),
        Question(questionId: "4", questionText: "What is the capital of China?", correctAnswer: "Beijing", choices: [
            QuizChoice(choice: "A", answer: "Beijing"),
            QuizChoice(choice: "B", answer: "Shanghai"),
            QuizChoice(choice: "C", answer: "Guangzhou"),
            QuizChoice(choice: "D", answer: "Shenzhen")
        ]),
        Question(questionId: "5", questionText: "What is the capital of Thailand?", correctAnswer: "Bangkok", choices: [
            QuizChoice(choice: "A", answer: "Bangkok"),
            QuizChoice(choice: "B", answer: "Phuket"),
            QuizChoice(choice: "C", answer: "Chiang Mai"),
            QuizChoice(choice: "D", answer: "Pattaya")
        ]),
        Question(questionId: "6", questionText: "What is the capital of Singapore?", correctAnswer: "Singapore", choices: [
            QuizChoice(choice: "A", answer: "Singapore"),
            QuizChoice(choice: "B", answer: "Sentosa"),
            QuizChoice(choice: "C", answer: "Jurong"),
            QuizChoice(choice: "D", answer: "Changi")
        ])
    ])
}
