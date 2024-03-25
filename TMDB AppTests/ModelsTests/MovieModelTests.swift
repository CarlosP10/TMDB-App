@testable import TMDB_App
import XCTest

final class MovieModelTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in MovieModelTests")
    //    }
    
    func testInitializationWithValidData() {
        let movie = movieModelData
        
        XCTAssertEqual(movie.adult, false)
        XCTAssertEqual(movie.backdropPath, "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg")
    }
    
    func testDecodingFromJSON() {
        let json = """
                {
                  "adult": false,
                  "backdrop_path": "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg",
                  "genre_ids": [
                    12,
                    28,
                    878
                  ],
                  "id": 299536,
                  "original_language": "en",
                  "original_title": "Avengers: Infinity War",
                  "overview": "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.",
                  "popularity": 226.803,
                  "poster_path": "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
                  "release_date": "2018-04-25",
                  "title": "Avengers: Infinity War",
                  "video": false,
                  "vote_average": 8.248,
                  "vote_count": 28652
                }
            """
        
        let jsonData = json.data(using: .utf8)!
        do {
            let movie = try JSONDecoder().decode(MovieModel.self, from: jsonData)
            XCTAssertEqual(movie.adult, false)
            XCTAssertEqual(movie.backdropPath, "/mDfJG3LC3Dqb67AZ52x3Z0jU0uB.jpg")
        } catch {
            XCTFail("Failed to decode MovieModel from JSON: \(error)")
        }
    }
}
