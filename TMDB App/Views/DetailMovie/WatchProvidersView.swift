//
//  WatchProvidersView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 24/3/24.
//

import SwiftUI

struct WatchProvidersView: View {
    //MARK: - PROPERTIES
    let title: String
    let providers: [FlatrateMovieWatch]
    @StateObject private var viewModel = ImageCarouselViewModel()
    
    //MARK: - UI
    var body: some View {
        let screenBounds = UIScreen.main.bounds
        if !providers.isEmpty {
            VStack(alignment: .leading) {
                Text(title)
                    .modifier(TitleModifier())
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 10) {
                        ForEach(0..<viewModel.imagePoster.count, id: \.self) { index in
                            VStack(spacing:0) {
                                if let image = viewModel.imagePoster[index] {
                                    Image(uiImage: image)
                                        .castModifier()
                                        .frame(maxHeight: 100)
                                } else {
                                    Image(systemName: "tv.circle.fill")
                                        .castModifier()
                                        .frame(maxHeight: 100)
                                }
                            }
                            .frame(width: screenBounds.width / 4, height: screenBounds.height / 6)
                        }
                        
                    }
                    .padding(.horizontal)
                }
            }.onAppear {
                let images = providers.compactMap { $0.logoPath }
                viewModel.loadImages(images)
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    WatchProvidersView(title:"Buy:", providers: providersData)
}
