//
//  Haptics.swift
//  ReCall
//
//  Created by Raphaël on 22/02/2025.
//

import SwiftUI
import AudioToolbox

@MainActor
func longVibration() {
    @AppStorage("hapticsEnabled") var hapticsEnabled: Bool = true

    if hapticsEnabled {
        let duration: TimeInterval = 2.0
        let interval: TimeInterval = 0.4
        
        var timer: Timer?
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak timer] _ in
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            timer?.invalidate()
            timer = nil
        }
    }
}

@MainActor
func feedback() {
    @AppStorage("hapticsEnabled") var hapticsEnabled: Bool = true

    if hapticsEnabled {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}
