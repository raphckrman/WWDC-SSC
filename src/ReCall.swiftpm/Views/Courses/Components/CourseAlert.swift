//
//  CourseAlert.swift
//  ReCall
//
//  Created by Raphaël on 05/01/2025.
//

import SwiftUI

struct CourseAlert: View {
    var icon: String
    var text: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title)
            Text(text)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(color)

        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.2))
        .cornerRadius(16)
    }
}
