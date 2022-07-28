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
    
    func requestCloudData(record: String, completion: @escaping (_ record: CKRecord) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: record, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.database = container.publicCloudDatabase
        
        if #available(iOS 15.0, *) {
            operation.recordMatchedBlock = { recordID, result in
                switch result {
                case .success(let record):
                    completion(record)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            operation.recordFetchedBlock = { (record: CKRecord?) in
                if let record = record {
                    print(record)
                }
            }
        }
        operation.start()
    }
}


enum ICloudService {
    static private let manager = ICloudManager(id: "iCloud.GaNaDaCloud")
}

extension ICloudService {
    static func requestAllHistoryQuizs() {
        manager.requestCloudData(record: "QuizHistory") { record in
            print(">>")
            print(record["rightAnswer"] ?? "")
        }
    }
    
    static func decode(_ ckRecord: CKRecord) throws {
        let keyIntersection = Set(self.dtoEncoded.dictionary.keys).intersection(ckRecord.allKeys())
        var dictionary: [String: Any?] = [:]

        keyIntersection.forEach {

            if let asset = ckRecord[$0] as? CKAsset {
                dictionary[$0] = try? self.data(from: asset)
            } else {
                dictionary[$0] = ckRecord[$0]
            }
        }
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary) else { throw Errors.LocalData.isCorrupted }
        guard let dto = try? JSONDecoder().decode(self.DTO, from: data) else { throw  Errors.LocalData.isCorrupted }
        do { try decode(dto) }
        catch { throw error }
    }
}

