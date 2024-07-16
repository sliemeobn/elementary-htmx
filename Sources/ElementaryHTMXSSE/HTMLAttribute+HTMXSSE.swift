import Elementary
import ElementaryHTMX

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for the HTMX SSE-extension.
    /// See the [htmx-sse reference](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/sse/README.md) for more information.
    enum sse {}
}

public extension HTMLAttribute.sse {
    static func connect(_ url: String) -> HTMLAttribute {
        .init(name: "sse-connect", value: url)
    }

    static func swap(_ eventName: String) -> HTMLAttribute {
        .init(name: "sse-swap", value: eventName)
    }

    static func close(_ eventName: String) -> HTMLAttribute {
        .init(name: "sse-close", value: eventName)
    }
}
