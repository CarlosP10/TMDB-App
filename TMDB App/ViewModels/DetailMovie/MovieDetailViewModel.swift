//
//  MovieDetailViewModel.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import Foundation
import SwiftUI

// MARK: Movie Detail View Model
final class MovieDetailViewModel: ObservableObject {
    @Published private(set) var movieDetails: MovieDetailModel? = nil
    @Published private(set) var movieImages: MovieImages? = nil
    @Published private(set) var movieCast = [Cast]()
    @Published private(set) var movieSimilars = [MovieModel]()
    @Published private(set) var movieWatchProviderBuy = [FlatrateMovieWatch]()
    @Published private(set) var movieWatchProviderRent = [FlatrateMovieWatch]()
    @Published private(set) var movieWatchProviderWatch = [FlatrateMovieWatch]()
    @Published private(set) var movieTrailers = [String]()
    @Published private(set) var error: Error? = nil
    
    public let movie: MovieModel
    private let movieId: Int
    
    init(movie: MovieModel) {
        self.movie = movie
        self.movieId = movie.id
    }
    
    func loadMovieDetails(completion: @escaping (Result<Bool, Error>) -> Void) {
        let resource = Resource<MovieDetailModel>(url: URL.getMovieDetail(movieId))
        TMDBService.shared.load(resource) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.movieDetails = responseModel
                    completion(.success(true))
                }
            case .failure(let error):
                completion(.failure(error))
                print(String(describing: error))
            }
        }
    }
    
    func loadMovieImages() {
        let resource = Resource<MovieImages>(url: URL.getMovieImages(movieId))
        TMDBService.shared.load(resource) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.movieImages = responseModel
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func loadMovieTrailer() {
        let resource = Resource<MovieVideo>(url: URL.getMovieVideos(movieId))
        TMDBService.shared.load(resource) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let videos = responseModel.results {
                        let trailerKeys = videos
                            .filter { $0.type == .trailer }
                            .compactMap { $0.key }
                        self.movieTrailers = trailerKeys
                    }
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func loadMovieCrew() {
        let resource = Resource<MovieCast>(url: URL.getMovieCrew(movieId))
        TMDBService.shared.load(resource) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let cast = responseModel.crew {
                        let crew = cast
                            .filter { $0.department == .crew }
                        self.movieCast = crew
                    }
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func loadMovieWatchProviders() {
        let resource = Resource<MovieWatchProvidersResults>(url: URL.getMovieWatchProvider(movieId))
        TMDBService.shared.load(resource) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let self = self else { return }
                if let results = responseModel.results,
                   let us = results.us {
                    DispatchQueue.main.async {
                        self.movieWatchProviderBuy = us.buy ?? []
                        self.movieWatchProviderRent = us.rent ?? []
                        self.movieWatchProviderWatch = us.flatrate ?? []
                    }
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    
}
