//
//  FolderItem.swift
//  ReCall
//
//  Created by Raphaël on 23/12/2024.
//

import Foundation
import SwiftData

@Model
@available(iOS 17, *)
class FolderItem: Identifiable {
    var id: UUID
    var name: String
    var subject: String
    var lastReviewedDate: Date
    var createdOn: Date
    var favorite: Bool
    var reviewCount: Int
    var examDate: Date?
    var flashcards: [FlashcardItem]
    var nextReviewDate: Date

    init(name: String, subject: String, examDate: Date? = nil) {
        self.id = UUID()
        self.name = name
        self.subject = subject
        self.lastReviewedDate = Date()
        self.createdOn = Date()
        self.examDate = examDate
        self.favorite = false
        self.flashcards = []
        self.nextReviewDate = Date()
        self.reviewCount = 0
    }
    
    func addFlashcard(question: String, answer: String, difficulty: CGFloat) {
        let flashcard = FlashcardItem(folder: self, question: question, answer: answer, difficulty: difficulty)
        flashcards.append(flashcard)
    }
    
    func removeFlashcard(id: UUID) {
        flashcards.removeAll { $0.id == id }
    }
    
    func updateNextReviewDate() {
        guard !flashcards.isEmpty else {
            self.nextReviewDate = Date()
            return
        }
        
        let totalTimeInterval = flashcards.reduce(0.0) { total, card in
            return card.nextReview > Date() ? total + card.nextReview.timeIntervalSinceReferenceDate : total
        }
        
        if totalTimeInterval > 0 {
            let averageTimeInterval = totalTimeInterval / Double(flashcards.count)
            self.nextReviewDate = Date(timeIntervalSinceReferenceDate: averageTimeInterval)
        } else {
            self.nextReviewDate = Date()
        }
        
        self.reviewCount += 1
    }

}
