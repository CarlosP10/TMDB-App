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
    
    //MARK: - MOVIES
    static var getMovie: URL {
        URL(string: "/3/search/movie", relativeTo: Self.tmdbURL)!
    }
    
    static func getMovie(_ endpoint: TMDBEndpoint) -> URL {
        URL(string: "/3/movie/\(endpoint.rawValue)", relativeTo: Self.tmdbURL)!
    }
    
    static func getMovieDetail(_ id: Int) -> URL {
        return URL(string: "/3/movie/\(id)", relativeTo: Self.tmdbURL)!
    }
    
    static func getMovieSimilar(_ id: Int) -> URL {
        return URL(string: "/3/movie/\(id)/similar", relativeTo: Self.tmdbURL)!
    }
    
    static func getMovieWatchProvider(_ id: Int) -> URL {
        return URL(string: "/3/movie/\(id)/watch/providers", relativeTo: Self.tmdbURL)!
    }
    
    //MARK: - IMAGES
    static func getBackDropPath(_ image: String, _ width: Int = 500) -> URL {
        return URL(string: "/t/p/w\(width)/"+image, relativeTo: Self.images)!
    }
    
    static func getMovieImages(_ id: Int) -> URL {
        return URL(string: "/3/movie/\(id)/images", relativeTo: Self.tmdbURL)!
    }
    
    //MARK: - VIDEOS
    static func getYoutubeTrailer(_ key: String) -> URL {
        return URL(string: "https://www.youtube.com/embed/\(key)")!
    }
    
    static func getMovieVideos(_ id: Int) -> URL {
        return URL(string: "/3/movie/\(id)/videos", relativeTo: Self.tmdbURL)!
    }
    
    //MARK: - Credits
    static func getMovieCrew(_ id: Int) -> URL {
        return URL(string: "/3/movie/\(id)/credits", relativeTo: Self.tmdbURL)!
    }
}

