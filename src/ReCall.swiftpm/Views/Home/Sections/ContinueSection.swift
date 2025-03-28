//
//  ContinueSection.swift
//  ReCall
//
//  Created by Raphaël on 24/12/2024.
//

import SwiftUI

@available(iOS 17, *)
struct ContinueSection: View {
    var folders: [FolderItem]
    @Binding var selectedTab: Int
    @State private var selectedFolder: FolderItem?
    @State private var showCourseCreate = false
    
    var body: some View {
        sectionTitle(title: "Continue") {
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    Spacer()
                    if folders.isEmpty {
                        MissingRecentCourse(action: {
                            showCourseCreate.toggle()
                        }, title: "Create my first course!")
                        TipsCard(sentence: "Frequent, short sessions are more effective than long cram sessions.")
                        TipsCard(sentence: "Study anytime, even without internet. This app works entirely offline.")
                        TipsCard(sentence: "Work for 25 minutes, then take a 5-minute break to stay focused and productive.")
                    } else {
                        ForEach(folders.sorted(by: { $0.lastReviewedDate > $1.lastReviewedDate }), id: \.id) { folder in
                            ContinueCourseCard(folder: folder)
                                .transition(.move(edge: .trailing))
                                .animation(.easeInOut(duration: 0.3), value: folders)
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 40)
                .scrollTargetLayout()
            }
            .padding(.vertical, -40)
            .scrollTargetBehavior(.viewAligned)
        }
        .sheet(isPresented: $showCourseCreate) {
            CourseCreate()
                .presentationDetents([.fraction(0.45)])
        }
    }
}
