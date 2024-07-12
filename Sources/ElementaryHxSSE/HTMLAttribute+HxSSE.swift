import Elementary
import ElementaryHTMX

public extension HTMLAttribute.hx where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for the HTMX SSE-extension.
    /// See the [htmx-sse reference](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/sse/README.md) for more information.
    enum sse {}
}

// TODO: implement API for event listeners for HTMX-SSE-events
// https://github.com/bigskysoftware/htmx-extensions/blob/main/src/sse/README.md#listening-to-events-dispatched-by-this-extension

public extension HTMLAttribute.hx.sse {
    static func connect(_ url: String) -> HTMLAttribute {
        .init(name: "sse-connect", value: url)
    }

    static func swap(_ eventName: String) -> HTMLAttribute {
        .init(name: "sse-swap", value: eventName)
    }

    static func close(_ eventName: String) -> HTMLAttribute {
        .init(name: "sse-close", value: eventName)
    }

    static func trigger(_ eventName: String) -> HTMLAttribute {
        .init(name: "hx-trigger", value: "sse:\(eventName)")
    }
}
