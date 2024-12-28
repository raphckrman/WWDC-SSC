//
//  DaysUntilText.swift
//  ReCall
//
//  Created by Raphaël on 28/12/2024.
//

import SwiftUI

func daysUntilText(from date: Date) -> String {
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    let target = calendar.startOfDay(for: date)
    
    if let daysBetween = calendar.dateComponents([.day], from: today, to: target).day {
        if daysBetween > 0 {
            return "In \(daysBetween) days"
        } else if daysBetween == 0 {
            return "Today"
        } else {
            return "\(abs(daysBetween)) days ago"
        }
    }
    return "Invalid date"
}
