@testable import TMDB_App
import XCTest

final class MovieDetailViewModelTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in MovieDetailViewModelTests")
    //    }
    let movie = movieModelData
    
    func testLoadMovieDetailsSuccess() {
        let viewModel = MovieDetailViewModel(movie: movie)
        let expectation = XCTestExpectation(description: "Movie details loaded successfully")
        
        viewModel.loadMovieDetails { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success, "Movie details should be loaded successfully")
                XCTAssertNotNil(viewModel.movieDetails, "Movie details should not be nil after loading")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to load movie details with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadMovieDetailsFailure() {
        let viewModel = MovieDetailViewModel(movie: movieModelDataFail)
        let expectation = XCTestExpectation(description: "Failed to load movie details")
        
        viewModel.loadMovieDetails { result in
            switch result {
            case .success:
                XCTFail("Movie details should not be loaded successfully")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadMovieImagesSuccess() {
        let viewModel = MovieDetailViewModel(movie: movie)
        let expectation = XCTestExpectation(description: "Movie images loaded successfully")
        
        viewModel.loadMovieImages()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(viewModel.movieImages, "Movie images should not be nil after loading")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadMovieImagesFailure() {
        let viewModel = MovieDetailViewModel(movie: movieModelDataFail)
        let expectation = XCTestExpectation(description: "Failed to load movie images")
        
        viewModel.loadMovieImages()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNil(viewModel.movieImages, "Movie images should be nil after loading failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadMovieCrewSuccess() {
        let viewModel = MovieDetailViewModel(movie: movie)
        let expectation = XCTestExpectation(description: "Movie crew loaded successfully")
        
        viewModel.loadMovieCrew()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(viewModel.movieCast.isEmpty, "Movie crew should not be empty after loading")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadMovieCrewFailure() {
        let viewModel = MovieDetailViewModel(movie: movieModelDataFail)
        let expectation = XCTestExpectation(description: "Failed to load movie crew")
        
        viewModel.loadMovieCrew()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertTrue(viewModel.movieCast.isEmpty, "Movie crew should be empty after loading failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadMovieTrailerSuccess() {
        let viewModel = MovieDetailViewModel(movie: movie)
        let expectation = XCTestExpectation(description: "Movie trailers loaded successfully")
        
        viewModel.loadMovieTrailer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(viewModel.movieTrailers.isEmpty, "Movie trailers should not be empty after loading")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadMovieTrailerFailure() {
        let viewModel = MovieDetailViewModel(movie: movieModelDataFail)
        let expectation = XCTestExpectation(description: "Failed to load movie trailers")
        
        viewModel.loadMovieTrailer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertTrue(viewModel.movieTrailers.isEmpty, "Movie trailers should be empty after loading failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadMovieWatchProvidersSuccess() {
        let viewModel = MovieDetailViewModel(movie: movie)
        let expectation = XCTestExpectation(description: "Movie watch providers loaded successfully")
        
        viewModel.loadMovieWatchProviders()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(viewModel.movieWatchProviderBuy.isEmpty, "Movie watch providers (Buy) should not be empty after loading")
            XCTAssertFalse(viewModel.movieWatchProviderRent.isEmpty, "Movie watch providers (Rent) should not be empty after loading")
            XCTAssertFalse(viewModel.movieWatchProviderWatch.isEmpty, "Movie watch providers (Watch) should not be empty after loading")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadMovieWatchProvidersFailure() {
        let viewModel = MovieDetailViewModel(movie: movieModelDataFail)
        let expectation = XCTestExpectation(description: "Failed to load movie watch providers")
        
        viewModel.loadMovieWatchProviders()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertTrue(viewModel.movieWatchProviderBuy.isEmpty, "Movie watch providers (Buy) should be empty after loading failure")
            XCTAssertTrue(viewModel.movieWatchProviderRent.isEmpty, "Movie watch providers (Rent) should be empty after loading failure")
            XCTAssertTrue(viewModel.movieWatchProviderWatch.isEmpty, "Movie watch providers (Watch) should be empty after loading failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
}
