//
//  Settings.swift
//  Challenge3
//
//  Created by Domagoj Sutalo on 24.09.2021..
//

import Foundation

enum QuestionsNumber: String, CaseIterable {
    case three = "3"
    case five = "5"
    case ten = "10"
    case twenty = "20"
    case all = "All"
}

class Settings: ObservableObject {
    @Published var difficulty = 1
    @Published var numberOfQuestionsIndex = 0
    var questionsNumber = QuestionsNumber.allCases
    
    var numberOfQuestions: Int {
        if let numberOfQuestions = Int(questionsNumber[numberOfQuestionsIndex].rawValue) {
            if self.difficulty * 12 >= numberOfQuestions {
                return numberOfQuestions
            } else {
                return self.difficulty * 12
            }
            
        } else {
            return allQuestions
        }
        
    }
    
    var allQuestions: Int {
        return 12 * self.difficulty
    }
}
