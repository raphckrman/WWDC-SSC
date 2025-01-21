//
//  FlashcardCard.swift
//  ReCall
//
//  Created by Raphaël on 21/01/2025.
//

import SwiftUI

struct FlashcardCard: View {
    var question: String
    var answer: String
    var difficulty: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question)
                .lineLimit(1)
                .fontWeight(.bold)
            Text(answer)
                .lineLimit(2)
            Spacer()
                .frame(height: 15)
            HStack {
                Image(systemName: "calendar")
                Text(Date().formatted(.dateTime.day().month()))
                Spacer()
                    .frame(width: 20)
                Text("|")
                    .fontWeight(.bold)
                Spacer()
                    .frame(width: 20)
                Image(systemName: difficulty >= 0 ? "star.fill" : "star")
                Image(systemName: difficulty >= 1 ? "star.fill" : "star")
                Image(systemName: difficulty >= 2 ? "star.fill" : "star")
            }
            .foregroundColor(Color(UIColor.gray))
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .frame(maxWidth: 275)
    }
}

#Preview {
    FlashcardCard(question: "Un concert de soutien", answer: "Ein Benefizkonzert organisieren", difficulty: 0)
}
