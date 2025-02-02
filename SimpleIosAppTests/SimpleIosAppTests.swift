import XCTest
@testable import SimpleIosApp  // Allows testing the main app module

class SimpleIosAppTests: XCTestCase {

    func testExample() {
        let sum = 2 + 2
        XCTAssertEqual(sum, 4, "Basic math should work!")
    }

    func testTextChange() {
        let contentView = ContentView()
        XCTAssertEqual(contentView.textValue, "Hello, DevOps!", "Initial text should match.")
    }

}
