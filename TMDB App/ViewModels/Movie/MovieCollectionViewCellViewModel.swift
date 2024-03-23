//
//  MovieCollectionViewCellViewModel.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

final class MovieCollectionViewCellViewModel: Hashable, Equatable {
    public let title: String
    public let releaseDate: String
    public let starts: Double
    public let overview: String
    private let imageUrl: URL?

    // MARK: - Init

    init(title: String, releaseDate: String, starts: Double, overview: String, imageUrl: URL?) {
        self.title = title
        self.releaseDate = releaseDate
        self.starts = starts
        self.overview = overview
        self.imageUrl = imageUrl
    }

    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: Abstract to Image Manager
        guard let url = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }

    // MARK: - Hashable

    static func == (lhs: MovieCollectionViewCellViewModel, rhs: MovieCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(releaseDate)
        hasher.combine(starts)
        hasher.combine(overview)
        hasher.combine(imageUrl)
    }
}
