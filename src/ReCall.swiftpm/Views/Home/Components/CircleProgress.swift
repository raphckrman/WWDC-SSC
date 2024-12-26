//
//  CircleProgress.swift
//  ReCall
//
//  Created by Raphaël on 24/12/2024.
//

import SwiftUI

struct CircularProgressMaskedView: View {
    var height: CGFloat
    var goal: CGFloat
    var progression: CGFloat

    var body: some View {
        CircularProgress(height: height, goal: goal, progression: progression)
            .frame(height: height)
            .mask(
                Rectangle()
                    .frame(width: height * (320 / 300), height: height) // not sure again
                    .offset(y: -height / 2.14) // not sure but it's work
            )
    }
}

struct CircularProgress: View {
    var height: CGFloat
    var goal: CGFloat
    var progression: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.5)
                .stroke(Color(UIColor.gray), style: StrokeStyle(lineWidth: height * 0.05, lineCap: .round))
                .opacity(0.4)
                .rotationEffect(.degrees(180))
            Circle()
                .trim(from: 0, to: min(progression / goal * 0.5, 0.5))
                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: height * 0.05, lineCap: .round))
                .opacity(1)
                .rotationEffect(.degrees(180))
            VStack {
                Text("Today's Studying")
                    .font(.system(size: height * 0.06)) // don't ask why...
                    .fontWeight(.bold)
                Text("\(convertSecondsToMinutesAndSeconds(seconds: progression).minutes):\(convertSecondsToMinutesAndSeconds(seconds: progression).seconds)")
                    .font(.system(size: height * 0.20))
                    .fontWeight(.bold)
                Text("of your \(convertSecondsToMinutesAndSeconds(seconds: goal).minutes)-minutes goal")
                    .font(.system(size: height * 0.06))
                    .fontWeight(.regular)
            }.padding(.bottom, height * 0.36)
        }
    }
}

func convertSecondsToMinutesAndSeconds(seconds: CGFloat) -> (minutes: Int, seconds: Int) {
    let minutes = Int(seconds / 60)
    let remainingSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
    return (minutes, remainingSeconds)
}
