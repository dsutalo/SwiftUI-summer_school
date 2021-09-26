//
//  Questions.swift
//  Challenge3
//
//  Created by Domagoj Sutalo on 23.09.2021..
//

import Foundation
import SwiftUI

struct Questions {
    var questions = [Question]()
    
    init(difficulty: Int, numberOfQuestions: Int) {
        questions = generateQuestions(difficulty, numberOfQuestions)
    }
    
    func generateQuestions(_ difficulty: Int, _ numberOfQuestions: Int) -> [Question]{
        var allQuestions = [Question]()
        
        for i in 1...difficulty{
            for j in 1...12{
                let answer = String(i * j)
                allQuestions.append(Question(text: "\(i) x \(j) =", answer: answer))
            }
        }
        allQuestions.shuffle()
        let selectedQuestions = Array(allQuestions[0..<numberOfQuestions])
        return selectedQuestions
    }
}
