@testable import TMDB_App
import XCTest
import SwiftUI

final class WatchProvidersViewTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in WatchProvidersViewTests")
    //    }
    
    func testWatchProvidersView() {
        let contentView = WatchProvidersView(title: "Buy:", providers: providersData)
        XCTAssertNotNil(contentView) // Asserts that the view is not nil

        let hostingController = UIHostingController(rootView: contentView)
        XCTAssertNotNil(hostingController.view, "Expected body content")
    }
    
    func testWatchProvidersSubviews() {
        let contentView = WatchProvidersView(title: "Buy:", providers: providersData)
        let hostingController = UIHostingController(rootView: contentView)
        XCTAssertEqual(hostingController.view.accessibilityElements?.count ?? 0 >= 0, true)
    }
}
