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
    var examDate: Date?
    
    init(name: String, subject: String, examDate: Date?) {
        self.id = UUID()
        self.name = name
        self.subject = subject
        self.examDate = examDate
    }
}
