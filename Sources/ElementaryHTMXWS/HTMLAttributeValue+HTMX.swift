import Elementary
import ElementaryHTMX

public extension HTMLAttributeValue.HTMX.Extension {
    static var ws: Self { "ws" }
}

public extension HTMLAttributeValue.HTMX.EventTrigger {
    static func ws(_ eventName: String) -> Self {
        .init(rawValue: "ws:\(eventName)")
    }
}
