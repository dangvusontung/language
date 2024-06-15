//
//  BaseService.swift
//  Language Learning
//
//  Created by TungDVS on 29/11/2023.
//

import Foundation

open class BaseService {
    
    private let apiKeyManager: APIKeyManager
    private let urlSession: URLSession
    
    private let baseURL = URL(string: "https://api.openai.com/v1")!
    
    private let betaAPI: Bool
    
    init(
        apiKeyManager: APIKeyManager = DebugAPIManager(),
        urlSession: URLSession = .shared,
        betaAPI: Bool = false
    ) {
        self.apiKeyManager = apiKeyManager
        self.urlSession = urlSession
        self.betaAPI = betaAPI
    }
    
    private let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private func makeRequest(
        method: String,
        path: String,
        body: RequestBodyData?
    ) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.url?.append(path: path)
        request.httpMethod = method
        for (key, value) in makeHeader() {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body, let data = try? jsonEncoder.encode(body) {
            request.httpBody = data
        }
        
        return request
    }

    private func makeHeader() -> [String: String] {
        let apiKey = apiKeyManager.getAPIKey()
        var header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        if betaAPI {
            header["OpenAI-Beta"] = "assistants=v1"
        }
        
        return header
    }
    
    func create<ResultObject: Codable>(path: String, body: RequestBodyData?) async throws -> ResultObject {
        let request = makeRequest(method: "POST", path: path, body: body)
        
        let (result, response) = try await urlSession.data(for: request)
        
        return try handleResponse(result: result, response: response)
    }
    
    func retrieve<ResultObject: Codable>(path: String) async throws -> ResultObject {
        let request = makeRequest(method: "GET", path: path, body: nil)
        let (result, response) = try await urlSession.data(for: request)
        return try handleResponse(result: result, response: response)
    }

    private func handleResponse<ResultObject: Codable>(result: Data, response: URLResponse?) throws -> ResultObject {
        guard let response = response as? HTTPURLResponse else {
            throw "Unknow Error"
        }
        switch response.statusCode {
        case 200...299:
            do {
                let object = try jsonDecoder.decode(ResultObject.self, from: result)
                return object
            } catch {
                throw "Error decoding from jsont: \(error)"
            }
        default:
            throw "Try to check your request again"
        }
    }

}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidStatusCode
}
