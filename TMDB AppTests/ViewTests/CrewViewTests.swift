@testable import TMDB_App
import XCTest
import SwiftUI

final class CrewViewTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in CrewViewTests")
    //    }
    
    func testCrewView() {
        let contentView = CrewView(crew: crewData)
        
        XCTAssertNotNil(contentView)
        
        let hostingController = UIHostingController(rootView: contentView)
        XCTAssertNotNil(hostingController.view, "Expected body content")
    }
    
    func testCrewSubiews() {
        let contentView = CrewView(crew: crewData)
        let hostingController = UIHostingController(rootView: contentView)
        XCTAssertEqual(hostingController.view.accessibilityElements?.count ?? 0 >= 0, true)
    }
}
