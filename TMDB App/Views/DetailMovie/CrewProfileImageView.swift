//
//  CrewProfileImageView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 24/3/24.
//

import SwiftUI

struct CrewProfileImageView: View {
    let profilePath: String
    @State private var image: UIImage?
    
    var body: some View {
        LazyVStack {
            if let image = image {
                Image(uiImage: image)
                    .castModifier()
            } else {
                Image(systemName: "person.fill")
                    .castModifier()
            }
        }
        .onAppear {
            TMDBService.shared.fetchImage(URL.getBackDropPath(profilePath)) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                case .failure(let failure):
                    print("Failed to load image: \(failure)")
                }
            }
        }
    }
}

#Preview {
    CrewProfileImageView(profilePath: imagesData[0])
}
