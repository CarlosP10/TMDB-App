//
//  BelongsToCollection.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

struct BelongsToCollection: Codable {
    let id: Int
    let name, posterPath, backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
