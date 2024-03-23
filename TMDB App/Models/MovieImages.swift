//
//  MovieImages.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

struct MovieImages: Codable {
    let backdrops: [Backdrop]?
    let id: Int
    let logos, posters: [Backdrop]?
}
