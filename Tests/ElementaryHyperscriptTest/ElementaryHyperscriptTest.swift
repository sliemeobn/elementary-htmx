import Elementary
import ElementaryHyperscript
import TestUtilities
import XCTest

final class elementary_hyperscriptTests: XCTestCase {
    func testScript() {
        HTMLAttributeAssertEqual(.hyperscript("on click send hello to <form />"), "_", "on click send hello to <form />")
    }
}
