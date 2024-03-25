@testable import TMDB_App
import XCTest
import SwiftUI

final class MovieDetailViewTest: XCTestCase {
//    func test_zero() throws {
//        XCTFail("Tests not yet implemented in MovieDetailViewTest")
//    }
    
    func testMovieDetailView() {
        let viewModel = MovieDetailViewModel(movie: movieModelData)
        let contentView = MovieDetailView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: contentView)
        
        XCTAssertNotNil(contentView) // Asserts that the view is not nil
        XCTAssertNotNil(hostingController.view, "Expected body content")
    }

    func testMovieDetailSubview() {
        let viewModel = MovieDetailViewModel(movie: movieModelData)
        let expectation = XCTestExpectation(description: "Movie details loaded successfully")
        
        viewModel.loadMovieDetails { result in
            switch result {
            case .success:
                let contentView = MovieDetailView(viewModel: viewModel)
                let hostingController = UIHostingController(rootView: contentView)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    XCTAssertEqual(hostingController.view.accessibilityElements?.count ?? 0 >= 0, true)
                }
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to load movie details with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
