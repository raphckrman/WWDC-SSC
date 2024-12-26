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
    
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}
