@testable import TMDB_App
import XCTest

final class MovieCollectionViewCellViewModelTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in MovieCollectionViewCellViewModelTests")
    //    }
    
    func testFetchImage() {
        let imageUrl = URL.getBackDropPath(imagesData[0])
        let viewModel = MovieCollectionViewCellViewModel(
            title: "Avengers",
            releaseDate: "2022-01-01",
            starts: 4.5,
            overview: "Just testing avengers movie",
            imageUrl: imageUrl
        )
        
        let expectation = XCTestExpectation(description: "Image fetched successfully")
        
        viewModel.fetchImage { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Image data avengers should not be nil")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch image with error: \(error)")
            }
        }
        
        // Wait for the expectation after 10 seconds
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFailFetchImage() {
        let imageUrl:URL? = nil
        let viewModel = MovieCollectionViewCellViewModel(
            title: "Avengers",
            releaseDate: "2022-01-01",
            starts: 4.5,
            overview: "Just testing avengers movie",
            imageUrl: imageUrl
        )
        
        let expectation = XCTestExpectation(description: "Image not fetched successfully")
        
        viewModel.fetchImage { result in
            switch result {
            case .success(let data):
                XCTAssertNil(data, "Image data should be nil")
            case .failure(let error):
                let badUrl = error as? URLError == URLError(.badURL)
                XCTAssertTrue(badUrl, "Failed to fetch image bad url or nil url")
                //XCTFail("Failed to fetch image with error: \(error)")
                expectation.fulfill()
            }
        }
        
        // Wait for the expectation after 10 seconds
        wait(for: [expectation], timeout: 10.0)
    }
}
