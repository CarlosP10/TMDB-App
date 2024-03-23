//
//  SpokenLanguage.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
