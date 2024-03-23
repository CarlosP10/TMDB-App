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
    var movie: MovieModel
    
    // MARK: - INIT
    init(movie: MovieModel) {
        self.movie = movie
    }
    
    
    // MARK: - UI
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .center, spacing: 10, content: {
                AsyncImage(url: URL.getBackDropPath(movie.posterPath ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .frame(maxHeight: 250)
                            .padding(0)
                    case .failure(_):
                        Image(systemName: "ant.circle.fill").iconModifier()
                    case .empty:
                        Image(systemName: "photo.circle.fill").iconModifier()
                    @unknown default:
                        ProgressView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 10, content: {
                    HStack {
                        Text(movie.title ?? "")
                            .font(.system(size: 15, design: .serif))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal, 5)
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
                })
            })
        }
        .background(.white)
        .cornerRadius(15)
        .shadow(color: Color(L10n.Colors.blackTransparentLight), radius: 8, x: 0, y: 0)
    }
}

#Preview {
    MovieCollectionViewCell(movie: MovieModel(adult: false, backdropPath: "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg", posterPath: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg", genreIDS: [12, 28, 878], id: 299536, originalLanguage: "en", originalTitle: "Avengers: Infinity War", overview: "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.", popularity: 193.188, releaseDate: "2018-04-25", title: "Avengers: Infinity War", video: false, voteAverage: 8.25, voteCount: 28446))
        .frame(width: 200, height: 375, alignment: .center)
}
