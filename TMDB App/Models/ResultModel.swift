//
//  ResultsModel.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation


/// Model for get the results json and decode to any type with T
struct ResultModel<T: Codable>: Codable {
    let page: Int
    let results: [T]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
