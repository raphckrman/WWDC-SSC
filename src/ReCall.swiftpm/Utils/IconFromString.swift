//
//  IconFromString.swift
//  ReCall
//
//  Created by Raphaël on 31/12/2024.
//

func getIconFromString(word: String) -> String {
    let wordToIconMapping: [String: String] = [
        "Science": "atom",
        "Mathematics": "function",
        "Language": "character.bubble"
    ]
    
    return wordToIconMapping[word] ?? "book"
}
