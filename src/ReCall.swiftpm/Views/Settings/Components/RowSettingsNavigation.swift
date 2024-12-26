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
    var url: String?
    
    var body: some View {
        if (url != nil) {
            Button(action: {
                print("[DEBUG] Opening ", url!)
                UIApplication.shared.open(URL(string: url!)!)
            }) {
                Label {
                    Text(title)
                        .foregroundStyle(Color.primary)
                } icon: {
                    Image(systemName: icon)
                        .foregroundStyle(color)
                }
            }
        } else {
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
}
