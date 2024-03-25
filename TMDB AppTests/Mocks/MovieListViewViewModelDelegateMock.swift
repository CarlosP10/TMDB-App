//
//  MovieListViewViewModelDelegateMock.swift
//  TMDB AppTests
//
//  Created by Carlos Paredes on 25/3/24.
//

@testable import TMDB_App
import Foundation

class MovieListViewViewModelDelegateMock: MovieListViewViewModelDelegate {
    var didLoadInitialMoviesCallCount = 0
    var didLoadMoreMoviesCallCount = 0
    var didSelectMovieCallCount = 0
    var didChangeSementCallCount = 0

    func didLoadInitialMovies() {
        didLoadInitialMoviesCallCount += 1
    }

    func didLoadMoreMovies(with newIndexPaths: [IndexPath]) {
        didLoadMoreMoviesCallCount += 1
    }

    func didSelectMovie(_ movie: MovieModel) {
        didSelectMovieCallCount += 1
    }

    func didChangeSement() {
        didChangeSementCallCount += 1
    }
}
