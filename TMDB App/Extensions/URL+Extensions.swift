//
//  URL+Extensions.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

extension URL {
    static var tmdbURL: URL {
        URL(string: "https://api.themoviedb.org")!
    }
    
    static var images: URL {
        //https://image.tmdb.org/t/p/w500/
        URL(string: "https://image.tmdb.org")!
    }
    
    static var getMovie: URL {
        URL(string: "/3/search/movie", relativeTo: Self.tmdbURL)!
    }
    
    static func getBackDropPath(_ image: String, _ width: Int = 500) -> URL {
        return URL(string: "/t/p/w\(width)/"+image, relativeTo: Self.images)!
    }
    
    static func getMovieDetail(_ id: Int) -> URL {
        return URL(string: "/3/movie/\(id)", relativeTo: Self.tmdbURL)!
    }
    
    static func getMovieImages(_ id: Int) -> URL {
        return URL(string: "/3/movie/\(id)/images", relativeTo: Self.tmdbURL)!
    }
}

