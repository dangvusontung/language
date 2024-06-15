//
//  QuizRow.swift
//  Language Learning
//
//  Created by TungDVS on 04/12/2023.
//

import SwiftUI

/*
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
 struct QuizChoice: Codable {
 let choice: String
 let answer: String
 }
 */

struct QuizRow: View {
    
    var quiz: Quiz
    
    var body: some View {
        List {
            Text(quiz.title)
            ForEach(quiz.questions) { question in
                Text(question.questionText)
                // Grid view of choices
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(question.choices) { choice in
                        Button(action: {
                            
                        }, label: {
                            Text("\(choice.choice). \(choice.answer)")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        })
                        
                    }
                }
            }
            .selectionDisabled()
        }
        .selectionDisabled()
    }
}

#Preview {
    QuizRow(quiz: .previewQuiz)
}
