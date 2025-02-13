//
//  AcknowledgmentsView.swift
//  ReCall
//
//  Created by Raphaël on 13/02/2025.
//

import SwiftUI

struct AcknowledgmentsView: View {
    var body: some View {
        BaseView(title: "Acknowledgments") {
            List {
                Section {
                    RowSettingsNavigation(title: "Hacking with Swift", icon: "link", color: Color.accentColor, destination: AnyView(BlankView()), url: "https://hackingwithswift.com/")
                    RowSettingsNavigation(title: "Piotr Wozniak (SM-2)", icon: "person.fill", color: Color.accentColor, destination: AnyView(BlankView()), url: "https://super-memory.com/english/ol/sm2.htm")
                    RowSettingsNavigation(title: "Sebastian Leitner", icon: "person.fill", color: Color.accentColor, destination: AnyView(BlankView()), url: "https://en.wikipedia.org/wiki/Leitner_system")
                    RowSettingsNavigation(title: "Indently", icon: "person.fill", color: Color.accentColor, destination: AnyView(BlankView()), url: "https://www.youtube.com/@Indently")
                }
            }
            .frame(height: 300)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListHeaderHeight, 0)
        }
    }
}
