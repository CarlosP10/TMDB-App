@testable import TMDB_App
import XCTest

final class FavoritesViewControllerTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in FavoritesViewControllerTests")
    //    }
    
    var viewController: FavoritesViewController!
    
    override func setUp() {
        super.setUp()
        viewController = FavoritesViewController()
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testViewBackgroundColor() {
        XCTAssertEqual(viewController.view.backgroundColor, UIColor.systemBackground, "View background color should be system background color")
    }
    
    func testTitle() {
        XCTAssertEqual(viewController.title, "Favorites", "Title should be 'Favorites'")
    }
}
