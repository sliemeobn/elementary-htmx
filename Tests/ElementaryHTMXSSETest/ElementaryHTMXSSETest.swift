import Elementary
import ElementaryHTMXSSE
import XCTest

final class elementary_htmxsseTests: XCTestCase {
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
