//
//  NetworkService.swift
//  GaNaDa
//
//  Created by Moon Jongseek on 2022/07/25.
//

import Foundation

enum NetworkService {
    static let baseURL = "http://ec2-3-237-49-198.compute-1.amazonaws.com/quiz/"
    static let manager = NetworkManager(baseURL: baseURL)
}

extension NetworkService {
    static func requestFirstUserToken(_ completeHandler: @escaping NetworkClosure<User>) {
        self.manager.getRequest(route: .firstUserToken) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                    completeHandler(.failure(NetworkError.errorDecodingJson))
                    return
                }
                completeHandler(.success(user))
            case .failure(let error):
                completeHandler(.failure(error))
            }
        }
    }
    
    static func requestTodayQuiz(_ completeHandler: @escaping NetworkClosure<[Quiz]>) {
        self.manager.getRequest(route: .todayQuiz) { result in
            switch result {
            case .success(let data):
                guard let todayQuiz = try? JSONDecoder().decode([Quiz].self, from: data) else {
                    completeHandler(.failure(NetworkError.errorDecodingJson))
                    return
                }
                completeHandler(.success(todayQuiz))
            case .failure(let error):
                completeHandler(.failure(error))
            }
        }
    }
    
    static func requestSubmitAnswer(submitAnswer: SubmitAnswerDTO, _ completeHandler: @escaping NetworkClosure<Int>) {
        self.manager.postRequest(route: .submitAnswer, body: submitAnswer) { result in
            switch result {
            case .success(let data):
                guard let resultExp = try? JSONDecoder().decode(Int.self, from: data) else {
                    completeHandler(.failure(NetworkError.errorDecodingJson))
                    return
                }
                completeHandler(.success(resultExp))
            case .failure(let error):
                completeHandler(.failure(error))
            }
        }
    }
}
