//
//  FlashcardItem.swift
//  ReCall
//
//  Created by Raphaël on 14/01/2025.
//

import Foundation
import SwiftData

@Model
@available(iOS 17, *)
class FlashcardItem: Identifiable {
    var id: UUID
    var folder: FolderItem
    var question: String
    var answer: String
    var difficulty: CGFloat
    var createdOn: Date
    var factor: CGFloat
    var interval: Int
    var reviewCount: Int
    var nextReview: Date

    init(folder: FolderItem, question: String, answer: String, difficulty: CGFloat) {
        self.id = UUID()
        self.folder = folder
        self.question = question
        self.answer = answer
        self.createdOn = Date()
        self.difficulty = difficulty
        self.factor = 2.5
        self.interval = 1
        self.reviewCount = 0
        self.nextReview = Date()
    }
    
    func updateCard(errors: Int) {
        let quality: Int
        switch errors {
        case 0:
            quality = 5
        case 1:
            quality = 4
        case 2:
            quality = 3
        case 3:
            quality = 2
        default:
            quality = 1
        }

        let newFactor = factor - 0.8 + 0.28 * CGFloat(quality) - 0.02 * CGFloat(quality) * CGFloat(quality)
        factor = max(newFactor, 1.3)
        print(newFactor)

        if reviewCount == 0 {
            interval = 1
        } else if reviewCount == 1 {
            interval = 2
        } else {
            interval = Int(CGFloat(interval) * factor)
        }
        
        reviewCount += 1
        print(interval, reviewCount)

        let nextReviewDate = Calendar.current.date(byAdding: .day, value: interval, to: Date())!
        print(nextReviewDate)
        self.nextReview = nextReviewDate
    }
}
