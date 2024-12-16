import Elementary
import ElementaryHTMXSSE
import TestUtilities
import XCTest

final class ElementaryHTMXSSETests: XCTestCase {
    func testExtension() {
        HTMLAttributeAssertEqual(.hx.ext(.sse), "hx-ext", "sse")
    }

    func testAttributes() {
        HTMLAttributeAssertEqual(.sse.connect("/test"), "sse-connect", "/test")
        HTMLAttributeAssertEqual(.sse.swap("test"), "sse-swap", "test")
        HTMLAttributeAssertEqual(.sse.close("test"), "sse-close", "test")
    }

    func testAttributeValues() {
        HTMLAttributeAssertEqual(.hx.trigger(.sse("time")), "hx-trigger", "sse:time")
    }
}
