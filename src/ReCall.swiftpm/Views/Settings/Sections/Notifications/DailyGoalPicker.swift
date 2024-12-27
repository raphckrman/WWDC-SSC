//
//  DailyGoalPicker.swift
//  ReCall
//
//  Created by Raphaël on 27/12/2024.
//

import SwiftUI

struct DailyGoalPicker: View {
    @AppStorage("dailyGoal") private var dailyGoal: Int = 5
    private let dailyGoalRange = stride(from: 5, through: 1440, by: 5)

    var body: some View {
        NavigationStack {
            Picker("Your Daily Goal", selection: $dailyGoal) {
                ForEach(Array(dailyGoalRange), id: \.self) { number in
                    Text("\(number) min/day")
                        .frame(height: 30)
                        .fixedSize()
                }
            }
            .pickerStyle(WheelPickerStyle())
            .navigationTitle("Daily Goal")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
        }
    }
}
