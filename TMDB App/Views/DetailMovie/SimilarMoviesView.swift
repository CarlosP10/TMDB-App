//
//  SimilarMoviesView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 24/3/24.
//

import SwiftUI

struct SimilarMoviesView: View {
    // MARK: - Properties
    let movieId: Int
    
    @StateObject private var viewModel: MovieSimilarViewModel
    
    // MARK: - INIT
    init(id: Int) {
        self.movieId = id
        self._viewModel = StateObject(wrappedValue: MovieSimilarViewModel(movieId: id))
    }
    
    let screenBounds = UIScreen.main.bounds
    
    var body: some View {
        if !viewModel.movieSimilars.isEmpty {
            VStack(alignment: .leading) {
                Text("Similar Movies:")
                    .modifier(TitleModifier())
                ScrollView(.horizontal, showsIndicators: false) {
                     LazyHStack(alignment: .top, spacing: 10) {
                         ForEach(viewModel.movieSimilars, id: \.id) { movie in
                             VStack(alignment: .leading, spacing: 8) {
                                 MovieCollectionViewCell(movie: movie, false)
                                     .lineLimit(2)
                                     .padding(.bottom, 0)
                                     .frame(width: screenBounds.width / 3, height: screenBounds.height / 4)
                             }
                             .padding(.trailing, 10)
                             .onAppear {
                                 if viewModel.shouldLoadMoreMovies(movie) {
                                     viewModel.loadMovieSimilar()
                                 }
                             }
                         }
                     }
                     .padding(.horizontal)
                     .padding(.vertical, 10)
                 }
                 .onAppear {
                     viewModel.loadMovieSimilar()
             }
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    SimilarMoviesView(id: 299536)
}
