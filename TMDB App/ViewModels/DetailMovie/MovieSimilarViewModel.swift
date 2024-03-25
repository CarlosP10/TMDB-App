//
//  MovieSimilarViewModel.swift
//  TMDB App
//
//  Created by Carlos Paredes on 24/3/24.
//

import Foundation

final class MovieSimilarViewModel: ObservableObject {
    
    @Published private(set) var movieSimilars = [MovieModel]()
    private let movieId: Int
    private var currentPage = 1
    private var totalPages = 1
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func loadMovieSimilar() {
        guard currentPage <= totalPages else { return }
        
        let queryItems = [
            URLQueryItem(name: "page", value: String(currentPage))
        ]
        
        let resource = Resource<ResultModel<MovieModel>>(url: URL.getMovieSimilar(movieId), method: .get(queryItems))
        TMDBService.shared.load(resource) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.movieSimilars.append(contentsOf: responseModel.results)
                    self.currentPage += 1
                    self.totalPages = responseModel.totalPages
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
        
    }
    
    func shouldLoadMoreMovies(_ movie: MovieModel) -> Bool {
        if let lastMovie = movieSimilars.last,
           lastMovie.id == movie.id {
            return true
        }
        return false
    }
}
