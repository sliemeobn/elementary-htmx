import Elementary
import ElementaryHTMX

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for the HTMX SSE-extension.
    /// See the [htmx-sse reference](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/sse/README.md) for more information.
    enum ws {}
}

public extension HTMLAttribute.ws {
    static func connect(_ url: String) -> HTMLAttribute {
        .init(name: "ws-connect", value: url)
    }

    static var send: HTMLAttribute {
        .init(name: "ws-send", value: nil)
    }
}
