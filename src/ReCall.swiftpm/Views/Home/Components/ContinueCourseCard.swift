//
//  ContinueCourseCard.swift
//  ReCall
//
//  Created by Raphaël on 28/12/2024.
//

import SwiftUI

@available(iOS 17, *)
struct ContinueCourseCard: View {
    var folder: FolderItem
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            action?()
        }) {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(folder.subject)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text(folder.name)
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        Text("22 Flashcards • 53%")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.primary.opacity(0.6))
                            .padding(.top, 30)
                    }
                    Spacer().frame(width: 50)
                    VStack(alignment: .leading) {
                        Image(systemName: "atom")
                            .font(.system(size: 24))
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.accentColor)
                            .background(Color.accentColor.opacity(0.2))
                            .clipShape(Circle())
                        Spacer()
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.vertical, 5)
                .padding(.top, 10)
                
                HStack {
                    Spacer()
                }
                .frame(height: 15)
                .background(Color.accentColor)
            }
            .frame(height: 125)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
        }
        .buttonStyle(PressableScaleStyle())
    }
}
