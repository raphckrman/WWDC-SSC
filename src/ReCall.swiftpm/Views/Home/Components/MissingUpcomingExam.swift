//
//  MissingUpcomingExam.swift
//  ReCall
//
//  Created by Raphaël on 24/12/2024.
//

import SwiftUI

struct MissingUpcomingExam: View {
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            action?()
        }) {
            ZStack {
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 7) {
                        Image(systemName: "book.fill")
                            .font(.title)
                            .foregroundColor(.primary.opacity(0.5))
                        Text("Add your upcoming exams!")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary.opacity(0.5))
                    }
                    .padding(.all)
                    Spacer()
                }
            }
        }
    }
}
