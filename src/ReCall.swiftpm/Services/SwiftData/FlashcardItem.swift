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

    init(folder: FolderItem, question: String, answer: String, difficulty: CGFloat) {
        self.id = UUID()
        self.folder = folder
        self.question = question
        self.answer = answer
        self.createdOn = Date()
        self.difficulty = difficulty
    }
}
