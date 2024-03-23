//
//  ProductionCountry.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}
