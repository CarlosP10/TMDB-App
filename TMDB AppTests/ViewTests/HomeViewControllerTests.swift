@testable import TMDB_App
import XCTest

final class HomeViewControllerTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in HomeViewControllerTests")
    //    }
    
    var homeViewController: HomeViewController!
    
    override func setUp() {
        super.setUp()
        homeViewController = HomeViewController()
        homeViewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        homeViewController = nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(homeViewController, "HomeViewController should not be nil after initialization")
        XCTAssertEqual(homeViewController.title, "Explore", "Title should be set to 'Explore'")
        XCTAssertNotNil(homeViewController.movieListView)
    }
}
