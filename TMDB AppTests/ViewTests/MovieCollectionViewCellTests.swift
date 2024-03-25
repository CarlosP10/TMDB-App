@testable import TMDB_App
import XCTest

final class MovieCollectionViewCellTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in MovieCollectionViewCellTests")
    //    }
    
    let movie = movieModelData
    func testSynchronousInitialization() {
        let cell = MovieCollectionViewCell(movie: movie)
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell.showMoreData, true)
        XCTAssertNotEqual(cell.movie.id, 1)
    }
    
    func testAsynchronousImageLoading() {
        let cell = MovieCollectionViewCell(movie: movie)
        let expectation = XCTestExpectation(description: "Image loaded successfully")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Simulate image fetching completion
            cell.viewModel.fetchImage { result in
                switch result {
                case .success:
                    expectation.fulfill()
                case .failure:
                    XCTFail("Failed to load image")
                }
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
