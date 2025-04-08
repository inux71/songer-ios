//
//  PreferencesListItem.swift
//  Songer
//
//  Created by Kacper Grabiec on 08/04/2025.
//

import SwiftUI

struct PreferencesListItem: View {
    let title: String
    let genres: [String]
    
    init(title: String, genres: [String]) {
        self.title = title
        self.genres = genres
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            HStack {
                ForEach(genres, id: \.self) { genre in
                    Text(genre)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    PreferencesListItem(
        title: "Rock your body",
        genres: [
            "Rock",
            "Pop",
            "Hip-hop"
        ]
    )
}
