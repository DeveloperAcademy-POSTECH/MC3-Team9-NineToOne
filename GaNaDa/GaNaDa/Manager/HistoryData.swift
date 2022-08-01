//
//  HistoryData.swift
//  GaNaDa
//
//  Created by Noah Park on 2022/08/01.
//

import Foundation

final class HistoryData {
    static let shared = HistoryData()
    private init() {}
    
    var quizs: [Quiz] = []
    var rawQuizsByDate: [Dictionary<Date, [Quiz]>.Element] = []
    var rawQuizsByDateExceptToday: [Dictionary<Date, [Quiz]>.Element] = []
    var quizsByDate: [Dictionary<Date, [Quiz]>.Element] = []
    
    
}
