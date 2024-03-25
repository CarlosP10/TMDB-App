//
//  ImageCarouselView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import SwiftUI

struct ImageCarouselView: View {
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    var images:[String]
    @StateObject private var viewModel = ImageCarouselViewModel()
    
    var body: some View {
        LazyVStack {
            ZStack {
                ForEach(0..<viewModel.imagePoster.count, id: \.self) { index in
                    if let image = viewModel.imagePoster[index] {
                        Image(uiImage: image)
                            .imageModifier()
                            .cornerRadius(25)
                            .frame(width: 275, height: 200)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * 100 + dragOffset, y: 0)
                            .padding(40)
                            .zIndex(currentIndex == index ? 1 : 0)
                    } else {
                        Image(systemName: "photo.circle.fill").iconModifier()
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshold:CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(images.count - 1, currentIndex + 1)
                            }
                        }
                    })
            )
        }
        .onAppear {
            viewModel.loadImages(images)
        }
    }
}

#Preview {
    ImageCarouselView(images: imagesData)
}
