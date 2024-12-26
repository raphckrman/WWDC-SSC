//
//  RowSettingsToggle.swift
//  ReCall
//
//  Created by Raphaël on 26/12/2024.
//

import SwiftUI

struct RowSettingsToggle: View {
    var title: String
    var icon: String
    var color: Color
    @State private var isOn: Bool = false
    var action: ((Bool) -> Void)? = nil

    var body: some View {
        Toggle(isOn: Binding(
            get: { isOn },
            set: { newValue in
                isOn = newValue
                action?(newValue)
            }
        )) {
            Label {
                Text(title)
                    .foregroundStyle(.primary)
            } icon: {
                Image(systemName: icon)
                    .foregroundStyle(color)
            }
        }
    }
}
