//
//  ICloudManager.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/07/27.
//

import Foundation
import CloudKit

final class ICloudManager {
    private let container: CKContainer
    
    init(id: String) {
        container = CKContainer(identifier: id)
    }
    
    func fetchRecordState(record: String, newState: Int, completion: @escaping () -> Void) {
        let recordID = CKRecord.ID(recordName: record)
        container.publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
            if let record = record, error == nil {
                record.setValue(newState, forKey: "status")
                self.container.publicCloudDatabase.save(record) { _, error in
                    print("fetch error")
                }
            }
        }
    }
    
    func createCloudData(record: String, postValue: [String: Any], completion: @escaping () -> Void) {
        let record = CKRecord(recordType: record)
        record.setValuesForKeys(postValue)
        container.publicCloudDatabase.save(record) { record, error in
            if let error = error {
                print(error)
            } else {
                completion()
            }
        }
    }
    
    func requestCloudData(record: String, completion: @escaping (_ records: [CKRecord]) -> Void) {
        var quizs: [CKRecord] = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: record, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "quizID", ascending: false)]
        let operation = CKQueryOperation(query: query)
        operation.database = container.publicCloudDatabase
        
        if #available(iOS 15.0, *) {
            operation.recordMatchedBlock = { recordID, result in
                switch result {
                case .success(let record):
                    quizs.append(record)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            operation.recordFetchedBlock = { (record: CKRecord?) in
                if let record = record {
                    quizs.append(record)
                }
            }
        }
        operation.start()
        if #available(iOS 15.0, *) {
            operation.queryResultBlock = { result in
                switch result {
                case .success(_):
                    completion(quizs)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            operation.queryCompletionBlock = { cursor, error in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    completion(quizs)
                }
            }
        }
    }
}
