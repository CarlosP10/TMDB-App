@testable import TMDB_App
import XCTest

final class TabBarControllerTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in TabBarControllerTests")
    //    }
    
    func testTabBarControllerSetup() {
        let tabBarController = TabBarController()
        
        tabBarController.loadViewIfNeeded()
        
        XCTAssertNotNil(tabBarController.viewControllers, "Tab bar controller should have view controllers")
        XCTAssertEqual(tabBarController.viewControllers?.count, 2, "Tab bar controller should have 2 view controllers")
        
        guard let viewControllers = tabBarController.viewControllers else {
            XCTFail("Tab bar controller's view controllers are nil")
            return
        }
        
        XCTAssertTrue(viewControllers[0] is UINavigationController, "First view controller should be a navigation controller")
        XCTAssertTrue(viewControllers[1] is UINavigationController, "Second view controller should be a navigation controller")
        
        guard let homeNav = viewControllers[0] as? UINavigationController,
              let favoritesNav = viewControllers[1] as? UINavigationController else {
            XCTFail("Failed to cast view controllers to UINavigationController")
            return
        }
        
        XCTAssertTrue(homeNav.topViewController is HomeViewController, "Top view controller of the first navigation controller should be HomeViewController")
        XCTAssertTrue(favoritesNav.topViewController is FavoritesViewController, "Top view controller of the second navigation controller should be FavoritesViewController")
        
        XCTAssertEqual(homeNav.tabBarItem.title, "Home", "Title of the Home tab should be 'Home'")
        XCTAssertEqual(favoritesNav.tabBarItem.title, "Favorites", "Title of the Favorites tab should be 'Favorites'")
        
        XCTAssertEqual(homeNav.tabBarItem.tag, 1, "Tag of the Home tab should be 1")
        XCTAssertEqual(favoritesNav.tabBarItem.tag, 2, "Tag of the Favorites tab should be 2")
    }
}
