//
//  TMDBEndpoint.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

/// Represents unique API endpoint
@frozen enum TMDBEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get now playing
    case nowPlaying = "now_playing"
    /// Endpoint to get popular
    case popular
    /// Endpoint to get top rated
    case topRated = "top_rated"
    /// Endpoint to get upcoming
    case upcoming
    
    var title: String {
        switch self {
        case .nowPlaying:
            "Now Playing"
        case .popular:
            "Popular"
        case .topRated:
            "Top Rated"
        case .upcoming:
            "Upcoming"
        }
    }
}
