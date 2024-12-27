//
//  OpenSettingsSection.swift
//  ReCall
//
//  Created by Raphaël on 27/12/2024.
//

import SwiftUI

struct OpenSettingsSection: View {
    private func openAppSettings() {
        let url = URL(string:UIApplication.openSettingsURLString)
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    var body: some View {
        Section {
            RowSettingsButton(title: "Open Settings", icon: "gearshape.fill", color: Color(UIColor.gray), action: { openAppSettings() })
        } header: {
            Spacer(minLength: 0).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        } footer: {
            Text("Click the button to open your device's settings and enable notifications.")
        }
    }
}
