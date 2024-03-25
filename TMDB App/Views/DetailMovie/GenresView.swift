//
//  GenresView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import SwiftUI

struct GenresView: View {
    
    var genres:[String] = []
    
    var body: some View {
        HStack(alignment: .bottom,spacing: 0) {
            ForEach(genres, id: \.self) { genre in
                Text(genre)
                    .font(.subheadline)
                    .fontWeight(.light)
                
                if genre != genres.last {
                    Text(", ")
                }
            }
        }
        .padding(.leading, 5)
        .padding(.bottom, 20)
        .font(.footnote)
        .foregroundColor(.gray)
    }
}

#Preview {
    GenresView(genres: ["Adventure","Action","Science"])
}
