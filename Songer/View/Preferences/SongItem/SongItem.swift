//
//  SongItem.swift
//  Songer
//
//  Created by Kacper Grabiec on 08/04/2025.
//

import SwiftUI

struct SongItem: View {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Image(systemName: "music.note")
            
            Text(title)
        }
    }
}

#Preview {
    SongItem(title: "Song 1")
}
