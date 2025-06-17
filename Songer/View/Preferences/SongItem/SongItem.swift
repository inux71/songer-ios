//
//  SongItem.swift
//  Songer
//
//  Created by Kacper Grabiec on 08/04/2025.
//

import SwiftUI

struct SongItem: View {
    let title: String
    let isSelected: Bool
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
    
    var body: some View {
        HStack {
            Image(systemName: "music.note")
                .foregroundStyle(isSelected ? .green : .primary)
            
            Text(title)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundStyle(isSelected ? .green : .primary)
            
            Spacer()
            
            
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

#Preview {
    SongItem(title: "Song 1", isSelected: true)
}
