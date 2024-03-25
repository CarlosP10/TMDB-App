//
//  MockupData.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import Foundation

let movieModelData:MovieModel = MovieModel(adult: false, backdropPath: "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg", posterPath: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg", genreIDS: [12, 28, 878], id: 299536, originalLanguage: "en", originalTitle: "Avengers: Infinity War", overview: "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.", popularity: 193.188, releaseDate: "2018-04-25", title: "Avengers: Infinity War", video: false, voteAverage: 8.25, voteCount: 28446)


let movieDetailModelData:MovieDetailModel = MovieDetailModel(adult: false, backdropPath: "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg", belongsToCollection: BelongsToCollection(id: 86311, name: "The Avengers Collection", posterPath: "/yFSIUVTCvgYrpalUktulvk3Gi5Y.jpg", backdropPath: "/zuW6fOiusv4X9nnW3paHGfXcSll.jpg"), budget: 300000000, genres: [Genre(id: 12, name: "Adventure"), Genre(id: 28, name: "Action"), Genre(id: 878, name: "Science Fiction")], homepage: "https://www.marvel.com/movies/avengers-infinity-war", id: 299536, imdbID: "tt4154756", originalLanguage: "en", originalTitle: "Avengers: Infinity War", overview: "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.", popularity: 193.188, posterPath: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg", productionCompanies: [ProductionCompany(id: 420, logoPath: "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png", name: "Marvel Studios", originCountry: "US")], productionCountries: [ProductionCountry(iso3166_1: "q", name: "a")], releaseDate: "2018-04-25", revenue: 2052415039, runtime: 149, spokenLanguages: [SpokenLanguage(englishName: "en", iso639_1: "e", name: "e")], status: "Released", tagline: "An entire universe. Once and for all.", title: "Avengers: Infinity War", video: false, voteAverage: 8.25, voteCount: 28446)

let crewData:[Cast] = [
    Cast(adult: false, gender: 1, id: 118545, knownForDepartment: .acting, name: "Dakota Johnson", originalName: "Dakota Johnson", popularity: 63.9, profilePath: "/rtxJfCCLdp1oi7bQ1ENVZRRkrJ5.jpg", castID: 232, character: "Cassandra Webb", creditID: "65fb61409408ec0164fb3da5", order: 0, department: nil, job: nil),
    Cast(adult: false, gender: 1, id: 115440, knownForDepartment: .acting, name: "Sydney Sweeney", originalName: "Sydney Sweeney", popularity: 232.64, profilePath: "/qYiaSl0Eb7G3VaxOg8PxExCFwon.jpg", castID: 5, character: "Julia Cornwall", creditID: "623224460582240045b30c3a", order: 1, department: nil, job: nil)
]

let providersData: [FlatrateMovieWatch] = [
    FlatrateMovieWatch(logoPath: "/7YPdUs60C9qQQQfOFCgxpnF07D9.jpg", providerID: 337, providerName: "Disney Plus", displayPriority: 0),
    FlatrateMovieWatch(logoPath: "/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg", providerID: 3, providerName: "Google Play Movies", displayPriority: 6),
]

let imagesData: [String] = ["lrStVAOVWUFBsQ4xj1LCjIhYTci.jpg", "8ubpqBDefJKOYfXaZ5IfEfBBdOR.jpg", "8elF67OY4skxC4MfdxxBGd2NemM.jpg", "5sZYbDSnDYZW5eDxlHzHwoC5W61.jpg"]
