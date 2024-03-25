//
//  MovieCollectionViewCell.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import SwiftUI

struct MovieCollectionViewCell: View {
    // MARK: - PROPERTIES
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    var showMoreData: Bool
    var movie: MovieModel
    @ObservedObject private var viewModel: MovieCollectionViewCellViewModel
    @State private var imagePoster: UIImage?
    
    // MARK: - INIT
    init(movie: MovieModel, _ showMoreData: Bool = true) {
        self.movie = movie
        self.viewModel = MovieCollectionViewCellViewModel(title: movie.title, releaseDate: movie.releaseDate, starts: movie.voteAverage, overview: movie.overview, imageUrl: URL.getBackDropPath(movie.posterPath ?? ""))
        self.showMoreData = showMoreData
    }
    
    
    // MARK: - UI
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .center, spacing: 10, content: {
                if let image = imagePoster {
                    Image(uiImage: image)
                        .resizable()
                        .frame(maxHeight: 250)
                        .padding(0)
                } else {
                    ProgressView()
                }
                
                VStack(alignment: .leading, spacing: 10, content: {
                    HStack {
                        Text(movie.title ?? "")
                            .font(.system(size: !showMoreData ? 10 : 15, design: .serif))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal, 5)
                    .padding(.bottom, !showMoreData ? 15: 0)
                    
                    
                    if showMoreData {
                        HStack {
                            Text(movie.releaseDate ?? "")
                                .font(.system(size: 13, design: .serif))
                                .fontWeight(.medium)
                            Spacer()
                            Image(systemName: "star.fill")
                                .font(.system(size: 13, design: .serif))
                            Text(String(movie.voteAverage ?? 0.0))
                                .font(.system(size: 13, design: .serif))
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal, 5)
                        
                        Text(movie.overview ?? "")
                            .font(.system(size: 12, design: .serif))
                            .fontWeight(.regular)
                            .lineLimit(3)
                            .lineSpacing(2)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 15)
                    }
                })
            })
        }
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .shadow(color: Color(L10n.Colors.blackTransparentLight), radius: 8, x: 0, y: 0)
        .onAppear() {
            viewModel.fetchImage { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        imagePoster = image
                    }
                case .failure(let failure):
                    imagePoster = UIImage(systemName: "ant.circle.fill")
                }
            }
        }
    }
}

#Preview {
    MovieCollectionViewCell(movie: movieModelData)
        .frame(width: 200, height: 375, alignment: .center)
}
