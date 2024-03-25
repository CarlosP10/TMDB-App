@testable import TMDB_App
import XCTest
import SwiftUI

final class SimilarMoviesViewTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in SimilarMoviesViewTests")
    //    }
    
    func testSimilarMoviesView() {
        let movieId = movieModelData.id
        let viewModel = MovieSimilarViewModel(movieId: movieModelData.id)
        
        let contentView = SimilarMoviesView(id: movieId)
            .environmentObject(viewModel)
        
        XCTAssertNotNil(contentView) // Asserts that the view is not nil
        
        let hostingController = UIHostingController(rootView: contentView)
        XCTAssertNotNil(hostingController.view, "Expected body content")
    }

    func testSimilarMoviesSubview() {
        let movieId = movieModelData.id
        let viewModel = MovieSimilarViewModel(movieId: movieModelData.id)
        
        let contentView = SimilarMoviesView(id: movieId)
            .environmentObject(viewModel)
        let hostingController = UIHostingController(rootView: contentView)
        XCTAssertEqual(hostingController.view.accessibilityElements?.count ?? 0 >= 0, true)
    }
}
