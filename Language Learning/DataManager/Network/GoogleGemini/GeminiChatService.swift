//
//  GeminiChatService.swift
//  Language Learning
//
//  Created by TungDVS on 18/12/2023.
//

import Foundation
import GoogleGenerativeAI

class GeminiChatService: GoogleAIChatService {
    
    private let chat: Chat
    
    init(apiKeyManager: APIKeyManager = GoogleAPIManager(), history: [ModelContent] = [])  {
        let model = GenerativeModel(name: GeminiModel.geminiPro.rawValue, apiKey: apiKeyManager.getAPIKey())
        self.chat = model.startChat(history: history)
    }
    
    @discardableResult
    func generate(messageContent: String) async throws -> AsyncThrowingStream<GenerateContentResponse, Error> {
        return chat.sendMessageStream(messageContent)
    }
//    
//    private func getChatHistory() -> [ModelContent] {
//        return chat.history
//    }
    
    func getStructuredMessage() {
        // In the Xcode Add Packages dialog, add this Swift package URL into the search bar:
        // https://github.com/google/generative-ai-swift

        // Add the following code to your Swift source code

        let config = GenerationConfig(
          temperature: 0.9,
          topP: 1,
          topK: 1,
          maxOutputTokens: 2048
        )

        // Don't check your API key into source control!
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
          fatalError("Add `API_KEY` as an Environment Variable in your app's scheme.")
        }

        let model = GenerativeModel(
          name: "gemini-1.5-pro",
          apiKey: apiKey,
          generationConfig: config,
          safetySettings: [
            SafetySetting(harmCategory: .harassment, threshold: .blockMediumAndAbove),
            SafetySetting(harmCategory: .hateSpeech, threshold: .blockMediumAndAbove),
            SafetySetting(harmCategory: .sexuallyExplicit, threshold: .blockMediumAndAbove),
            SafetySetting(harmCategory: .dangerousContent, threshold: .blockMediumAndAbove)
          ]
        )

        Task {
          do {
            let response = try await model.generateContent(
              "input: word",
              "output: {\n  \"word\": \"hello\",\n  \"definitions\": [\n    {\n      \"partOfSpeech\": \"greeting\",\n      \"definition\": \"Used as a greeting or to begin a phone conversation.\",\n      \"example\": \"Hello, how are you today?\"\n    },\n    {\n      \"partOfSpeech\": \"interjection\",\n      \"definition\": \"Used to attract attention.\",\n      \"synonyms\": [\"hey\", \"hi\"],\n      \"example\": \"Hello! Is anyone there?\"\n    }\n  ],\n  \"phonetics\": [\n    {\n      \"text\": \"/həˈloʊ/\",\n      \"audio\": \"https://example.com/audio/hello.mp3\"\n    }\n  ]\n}",
              "input: beautifil",
              "output: "
            )
            print(response.text ?? "No text available")
          } catch {
            print(error)
          }
        }
    }
}

enum GeminiModel: String, Codable {
    case geminiPro = "gemini-pro"
    case geminiProVision = "gemini-pro-vision"
}

extension ModelContent {
    init(modelContent content: String) {
        self.init(role: "model", parts: content)
    }
}

