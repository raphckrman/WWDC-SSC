//
//  RowSettingsList.swift
//  ReCall
//
//  Created by Raphaël on 26/12/2024.
//

import SwiftUI

struct RowSettingsNavigation: View {
    var title: String
    var icon: String
    var color: Color
    var destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
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
