//
//  NetworkManager.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/25.
//

import Foundation

typealias NetworkClosure<ResultType: Codable> = (Result<ResultType, NetworkError>) -> ()

enum HTTPMethod: String {
    case GET
    case POST
}

enum NetworkError: Error {
    case invalidData
    case invalidURL
    case failureRequest
    case failureResponse
    case errorEncodingJson
    case errorDecodingJson
}

enum Route: String {
    case firstUserToken
    case todayQuiz
    case submitAnswer
}

final class NetworkManager {
    let baseURL: String
    private var session = URLSession(configuration: URLSessionConfiguration.default,
                                     delegate: nil,
                                     delegateQueue: nil)
    
    private let request: (URL, HTTPMethod) -> URLRequest =  { url, method in
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    deinit {
        self.session.finishTasksAndInvalidate()
    }
}

extension NetworkManager {
    /// Internal Request Function
    private func sendRequest(with request: URLRequest, _ completeHandler: @escaping NetworkClosure<Data>) {
        self.session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completeHandler(.failure(.failureRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completeHandler(.failure(.invalidURL))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completeHandler(.failure(.failureResponse))
                return
            }
            
            guard let data = data else {
                completeHandler(.failure(.invalidData))
                return
            }
            completeHandler(.success(data))
        }
        .resume()
    }
    
    /// GET Request
    func getRequest(route: Route, _ completeHandler: @escaping NetworkClosure<Data>) {
        let urlString = self.baseURL + route.rawValue
        
        guard let url = URL(string: urlString) else {
            completeHandler(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = self.request(url, .GET)
        
        self.sendRequest(with: request, completeHandler)
    }
    
    /// POST Request
    func postRequest<D: Codable>(route: Route, body: D, _ completeHandler: @escaping NetworkClosure<Data>) {
        let urlString = self.baseURL + route.rawValue
        
        guard let url = URL(string: urlString) else {
            completeHandler(.failure(.invalidURL))
            return
        }
        
        var request = self.request(url, .POST)
        
        guard let httpBody = try? JSONEncoder().encode(body) else {
            completeHandler(.failure(.errorEncodingJson))
            return
        }
        request.httpBody = httpBody
        
        self.sendRequest(with: request, completeHandler)
    }
}

