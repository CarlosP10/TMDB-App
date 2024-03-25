//
//  ImageCarouselViewModel.swift
//  TMDB App
//
//  Created by Carlos Paredes on 24/3/24.
//

import SwiftUI

class ImageCarouselViewModel: ObservableObject {
    @Published var imagePoster = [UIImage?]()
    
    public func loadImages(_ imageURLs: [String]) {
        // Clear existing images
        imagePoster.removeAll()
        for url in imageURLs {
            let imageUrl = URL.getBackDropPath(url)
            TMDBService.shared.fetchImage(imageUrl) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.imagePoster.append(image)
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.imagePoster.append(UIImage(systemName: "ant.circle.fill"))
                    }
                }
            }
        }
    }
}
