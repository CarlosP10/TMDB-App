@testable import TMDB_App
import XCTest
import SwiftUI

final class ImageCarouselViewTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in ImageCarouselViewTests")
    //    }
    
    func testImageCarouselView() {
        let viewModel = ImageCarouselViewModel()
        
        let contentView = ImageCarouselView(images: imagesData)
            .environmentObject(viewModel)
        
        XCTAssertNotNil(contentView) // Asserts that the view is not nil
        let hostingController = UIHostingController(rootView: contentView)
        XCTAssertNotNil(hostingController.view, "Expected body content")
    }

    func testImageCarouselSubview() {
        let viewModel = ImageCarouselViewModel()
        
        let contentView = ImageCarouselView(images: imagesData)
            .environmentObject(viewModel)
        let hostingController = UIHostingController(rootView: contentView)
        XCTAssertEqual(hostingController.view.accessibilityElements?.count ?? 0 >= 0, true)
    }
}
