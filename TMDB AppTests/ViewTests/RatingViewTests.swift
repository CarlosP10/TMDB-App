@testable import TMDB_App
import XCTest
import SwiftUI

final class RatingViewTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in RatingViewTests")
    //    }
    
    func testRatingView() {
        let ratingView = RatingView(rating: 3, label: "Rating:")
        let hostingController = UIHostingController(rootView: ratingView)
        XCTAssertNotNil(hostingController.view, "RatingView is not nil")
    }
    
    func testRatingView_FullRating() {
        let ratingView = RatingView(rating: 5, label: "Rating:")
        let hostingController = UIHostingController(rootView: ratingView)
        //label+starts
        XCTAssertEqual(hostingController.view.accessibilityElements?.count, 6)
    }

    
}
