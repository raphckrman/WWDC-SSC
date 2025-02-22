//
//  SuccessReview.swift
//  ReCall
//
//  Created by Raphaël on 08/02/2025.
//

import SwiftUI

@available(iOS 17, *)
struct SuccessReview: View {
    var folder: FolderItem
    var learnedCardsCount: Int

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image(systemName: "medal.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.yellow)
                Text("Congratulation!")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 5)
                Text("You reviewed \(learnedCardsCount) \(learnedCardsCount >  1 ? "cards" : "card") out of \(folder.flashcards.count)!")
                    .font(.title3)
                    .fontWeight(.regular)
                
                HStack {
                    let daysUntilReview = max(1, Calendar.current.dateComponents([.day], from: Date(), to: folder.nextReviewDate).day ?? 1)

                    Image(systemName: "calendar")
                        .font(.system(size: 20))
                    Text("Your next session is in \(daysUntilReview) \(daysUntilReview > 1 ? "days" : "day")")
                        .fontWeight(.medium)
                }
                .padding(.top, 10)
                Spacer()
            }
        }
    }
}
