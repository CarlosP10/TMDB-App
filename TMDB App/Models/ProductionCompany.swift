//
//  ProductionCompany.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

struct ProductionCompany: Codable {
    let id: Int
    let logoPath, name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
