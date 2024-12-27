//
//  RowSettingsButton.swift
//  ReCall
//
//  Created by Raphaël on 27/12/2024.
//

import SwiftUI

struct RowSettingsButton: View {
    var title: String
    var icon: String
    var color: Color
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Label {
                Text(title)
                    .foregroundStyle(Color.primary)
            } icon: {
                Image(systemName: icon)
                    .foregroundStyle(color)
            }
        }
    }
}
