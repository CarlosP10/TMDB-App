//
//  MovieSaveViewModel.swift
//  TMDB App
//
//  Created by Carlos Paredes on 25/3/24.
//

import Foundation

class MovieSaveViewModel: ObservableObject {
    // UserDefaults key for storing saved movies
    private let savedMoviesKey = L10n.Identifiers.keyForMovie
    
    // Function to save a movie
    func saveMovie(_ movie: MovieDetailModel) {
        var savedMovies = loadSavedMovies()
        savedMovies.append(movie)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(savedMovies) {
            UserDefaults.standard.set(encoded, forKey: savedMoviesKey)
        }
    }
    
    // Function to load saved movies
    func loadSavedMovies() -> [MovieDetailModel] {
        if let savedMoviesData = UserDefaults.standard.data(forKey: savedMoviesKey) {
            let decoder = JSONDecoder()
            if let savedMovies = try? decoder.decode([MovieDetailModel].self, from: savedMoviesData) {
                return savedMovies
            }
        }
        return []
    }
}
