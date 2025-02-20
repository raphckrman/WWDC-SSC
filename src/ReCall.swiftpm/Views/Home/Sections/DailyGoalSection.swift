//
//  DailyGoalSection.swift
//  ReCall
//
//  Created by Raphaël on 24/12/2024.
//

import SwiftUI

@available(iOS 17, *)
struct DailyGoalSection: View {
    var height: CGFloat {
            UIDevice.current.userInterfaceIdiom == .pad ? 450 : 300
        }
    @AppStorage("dailyGoal") private var DailyGoal: Int = 10
    @State private var showModal = false

    var body: some View {
        sectionTitle(title: "Daily Goal") {
            HStack {
                Spacer()
                CircularProgressMaskedView(height: height, goal: CGFloat(DailyGoal*60), progression: 0)
                    .padding()
                    .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 50 : 0)
                    .onLongPressGesture {
                        showModal.toggle()
                   }
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    RoundedButton(title: "Start Studying", width: height)
                }
                Spacer()
            }
            .offset(y: -height / 2)
        }
        .sheet(isPresented: $showModal) {
            DailyGoalPicker()
                .presentationDetents([.fraction(0.3)])
        }
    }
}
