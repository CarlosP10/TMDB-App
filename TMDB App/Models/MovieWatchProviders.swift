//
//  MovieWatchProviders.swift
//  TMDB App
//
//  Created by Carlos Paredes on 24/3/24.
//

import Foundation

// MARK: - MovieWatchProviders
struct MovieWatchProvidersResults: Codable {
    let id: Int?
    let results: MovieWatchProviders?
}

// MARK: - Results
struct MovieWatchProviders: Codable {
    let us: AE?

    enum CodingKeys: String, CodingKey {
        case us = "US"
    }
}

// MARK: - Flatrate
struct FlatrateMovieWatch: Codable, Hashable {
    let logoPath: String?
    let providerID: Int?
    let providerName: String?
    let displayPriority: Int?

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
        case displayPriority = "display_priority"
    }
}

// MARK: - AE
struct AE: Codable {
    let link: String?
    let rent, buy, flatrate: [FlatrateMovieWatch]?
}
