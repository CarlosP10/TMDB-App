@testable import TMDB_App
import XCTest

final class MovieDetailModelTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in MovieDetailModelTests")
    //    }
    
    func testInitializationWithValidData() {
        let movieDetail = movieDetailModelData
        
        XCTAssertEqual(movieDetail.adult, false)
        XCTAssertEqual(movieDetail.budget, 300000000)
        XCTAssertEqual(movieDetail.backdropPath, "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg")
    }
    
    func testDecodingFromJSON() {
        let json = """
            {
              "adult": false,
              "backdrop_path": "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg",
              "belongs_to_collection": {
                "id": 86311,
                "name": "The Avengers Collection",
                "poster_path": "/yFSIUVTCvgYrpalUktulvk3Gi5Y.jpg",
                "backdrop_path": "/zuW6fOiusv4X9nnW3paHGfXcSll.jpg"
              },
              "budget": 300000000,
              "genres": [
                {
                  "id": 12,
                  "name": "Adventure"
                },
                {
                  "id": 28,
                  "name": "Action"
                },
                {
                  "id": 878,
                  "name": "Science Fiction"
                }
              ],
              "homepage": "https://www.marvel.com/movies/avengers-infinity-war",
              "id": 299536,
              "imdb_id": "tt4154756",
              "original_language": "en",
              "original_title": "Avengers: Infinity War",
              "overview": "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.",
              "popularity": 226.803,
              "poster_path": "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
              "production_companies": [
                {
                  "id": 420,
                  "logo_path": "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png",
                  "name": "Marvel Studios",
                  "origin_country": "US"
                }
              ],
              "production_countries": [
                {
                  "iso_3166_1": "US",
                  "name": "United States of America"
                }
              ],
              "release_date": "2018-04-25",
              "revenue": 2052415039,
              "runtime": 149,
              "spoken_languages": [
                {
                  "english_name": "English",
                  "iso_639_1": "en",
                  "name": "English"
                },
                {
                  "english_name": "Xhosa",
                  "iso_639_1": "xh",
                  "name": ""
                }
              ],
              "status": "Released",
              "tagline": "An entire universe. Once and for all.",
              "title": "Avengers: Infinity War",
              "video": false,
              "vote_average": 8.248,
              "vote_count": 28653
            }
            """
        
        let jsonData = json.data(using: .utf8)!
        do {
            let movieDetail = try JSONDecoder().decode(MovieDetailModel.self, from: jsonData)
            XCTAssertEqual(movieDetail.adult, false)
            XCTAssertEqual(movieDetail.backdropPath, "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg")
        } catch {
            XCTFail("Failed to decode MovieDetailModel from JSON: \(error)")
        }
    }
}
