@testable import TMDB_App
import XCTest

final class MovieSimilarViewModelTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in MovieSimilarViewModelTests")
    //    }
    
    func testLoadMovieSimilar() {
        let movieId = 299536 // Avengers Id
        let viewModel = MovieSimilarViewModel(movieId: movieId)
        let expectation = XCTestExpectation(description: "Movie similars loaded")
        
        viewModel.loadMovieSimilar()
        
        //Should be empty because is loading in background
        XCTAssertTrue(viewModel.movieSimilars.isEmpty, "Movie similars array should be empty before loading")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // Wait for at least 5 seconds to allow the asynchronous task to complete
            XCTAssertFalse(viewModel.movieSimilars.isEmpty, "Movie similars array should not be empty after loading")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testShouldNotLoadMoreMovies() {
        let movieId = 299536 // Avengers Id
        let viewModel = MovieSimilarViewModel(movieId: movieId)
        let movieModel = movieModelData
        
        let shouldLoadMore = viewModel.shouldLoadMoreMovies(movieModel)
        
        // Verify that shouldLoadMoreMovies returns true for a movie with the same id
        XCTAssertFalse(shouldLoadMore, "Should not load more movies because Avengers is not the last and movieSimilars is empty")
    }
    
    func testShouldLoadMoreMovies() {
        let movieId = 299536 // Avengers Id
        let viewModel = MovieSimilarViewModel(movieId: movieId)
        let movieModel = movieModelDataLast
        let expectation = XCTestExpectation(description: "Movie similars loaded")
        
        viewModel.loadMovieSimilar()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // Wait for at least 5 seconds to allow the asynchronous task to complete
            let movieModel2 = viewModel.movieSimilars.last
            let shouldLoadMore = viewModel.shouldLoadMoreMovies(movieModel2 ?? movieModel)
            
            // Verify that shouldLoadMoreMovies returns true for a movie with the same id
            XCTAssertTrue(shouldLoadMore, "Should load more movies because MovieData is the last")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
}
