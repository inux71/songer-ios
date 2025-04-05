//
//  AddPreferencesView.swift
//  Songer
//
//  Created by Kacper Grabiec on 05/04/2025.
//

import SwiftUI

struct AddPreferencesView: View {
    var body: some View {
        List {
            
        }.navigationTitle(Text(
            "Add preferences",
            comment: "Add preferences view navigation title"
        ))
    }
}

#Preview {
    NavigationStack {
        AddPreferencesView()
    }
}
