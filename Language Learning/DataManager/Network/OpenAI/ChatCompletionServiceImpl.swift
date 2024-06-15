//
//  OpenAIServiceImpl.swift
//  Language Learning
//
//  Created by TungDVS on 11/11/2023.
//

import Foundation

@MainActor
class ChatCompletionServiceImpl: ChatCompletionService {
    private let apiKeyManager: APIKeyManager
    private let urlSession: URLSession
    
    init(apiKeyManager: APIKeyManager = DebugAPIManager(), urlSession: URLSession = .shared) {
        self.apiKeyManager = apiKeyManager
        self.urlSession = urlSession
    }
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    func getAnswer(messages: [Message], model: String) async throws -> AsyncThrowingStream<String, Error> {
        
        var request = makeURLRequest(path: "/chat/completions")
        let chatcompletionRequest = ChatCompletionRequest(model: .gpt4turbo, messages: messages)
        request.httpBody = try? jsonEncoder.encode(chatcompletionRequest)
        let (result, response) = try await urlSession.bytes(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return AsyncThrowingStream { continuation in
            Task(priority: .userInitiated) {
                do {
                    var responseText = ""
                    for try await line in result.lines {
                        if !line.contains("data: [DONE]"){
                            print(line)
                            if let data = line.replacingOccurrences(of: "data: ", with: "").data(using: .utf8) {
                                let response = try jsonDecoder.decode(OpenAIChatCompletionResponse.self, from: data)
                                if let text = response.choices.first?.delta.content {
                                    responseText += text
                                    continuation.yield(responseText)
                                }
                            }
                        }
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
    
    private func makeURLRequest(path: String) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.url?.append(path: path)
        request.httpMethod = "POST"
        
        for (key, value) in makeHeader() {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    private func makeHeader() -> [String: String] {
        let apiKey = apiKeyManager.getAPIKey()
        let header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        return header
    }
    
}
