//
//  IconFromString.swift
//  ReCall
//
//  Created by Raphaël on 31/12/2024.
//

func getIconFromString(word: String) -> String {
    let wordToIconMapping: [String: String] = [
        "General": "book.fill",
        "Mathematics": "function",
        "Science": "atom",
        "Language": "character.bubble",
        "History": "calendar",
        "Technology": "desktopcomputer",
        "Art": "paintbrush.fill",
        "Music": "music.note",
        "Philosophy": "scissors",
        "Psychology": "brain.head.profile.fill",
        "Economics": "banknote.fill",
        "Business": "briefcase.fill",
        "Literature": "book.fill",
    ]
    
    return wordToIconMapping[word] ?? "book"
}
