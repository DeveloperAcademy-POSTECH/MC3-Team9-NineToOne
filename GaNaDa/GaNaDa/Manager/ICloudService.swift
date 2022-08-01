//
//  ICloudService.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/30.
//

import Foundation
import CloudKit

enum ICloudService {
    static private let manager = ICloudManager(id: "iCloud.GaNaDaCloud")
}

extension ICloudService {
    
    static func fetchHistoryQuiz() {
        let recordID = CKRecord.ID(recordName: "[record_name_here]")
        manager.fetch(withRecordID: recordID) { record, error in
            if let record = record, error == nil {

                //update your record here

                self.database.save(record) { _, error in
                    completion?(error)
                }
            }
        }
    }
    
    static func createNewHistoryQUiz(newQuiz: Quiz, completion: @escaping () -> Void) {
        let newQuizData: [String : Any] = ["quizID": newQuiz.quizID,
                                           "question": newQuiz.question,
                                           "type": newQuiz.typeRawValue,
                                           "rightAnswer": newQuiz.rightAnswer,
                                           "wrongAnswer": newQuiz.wrongAnswer,
                                           "description": newQuiz.description,
                                           "example": newQuiz.example,
                                           "status": newQuiz.stateRawValue,
                                           "publishedDate": newQuiz.publishedDate ?? Date()]
        manager.createCloudData(record: "QuizHistory", postValue: newQuizData) {
            completion()
        }
    }
    
    static func requestAllHistoryQuizs(completion: @escaping (_ quizs: [Quiz]) -> Void) {
        var quizs: [Quiz] = []
        manager.requestCloudData(record: "QuizHistory") { records in
            for record in records {
                let fetchedQuiz = Quiz(quizID: record["quizID"] as? Int ?? 0,
                                       question: record["question"] ?? "",
                                       typeRawValue: record["type"] as? Int ?? 0,
                                       rightAnswer: record["rightAnswer"] ?? "",
                                       wrongAnswer: record["wrongAnswer"] ?? "",
                                       description: record["description"] ?? "",
                                       example: record["example"] ?? [],
                                       stateRawValue: record["status"] as? Int ?? 0,
                                       publishedDate: record["publishedDate"])
                quizs.append(fetchedQuiz)
            }
            completion(quizs)
        }
    }
}
