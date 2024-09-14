import Elementary
import ElementaryHTMXWS
import TestUtilities
import XCTest

final class elementary_htmxsseTests: XCTestCase {
    func testExtension() {
        HTMLAttributeAssertEqual(.hx.ext(.ws), "hx-ext", "ws")
    }

    func testAttributes() {
        HTMLAttributeAssertEqual(.ws.connect("/test"), "ws-connect", "/test")
        HTMLAttributeAssertEqual(.ws.connect(.ws("/test")), "ws-connect", "ws:/test")
        HTMLAttributeAssertEqual(.ws.connect(.wss("/test")), "ws-connect", "wss:/test")
    }

    func testAttributeValues() {
        HTMLAttributeAssertEqual(.hx.trigger(.ws("time")), "hx-trigger", "ws:time")
    }

    func testWSSend() {
        HTMLAttributeAssertEqual(.ws.send, "ws-send", nil)
    }
}
