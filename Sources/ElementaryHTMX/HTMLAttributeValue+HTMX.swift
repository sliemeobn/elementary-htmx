import Elementary

public extension HTMLAttributeValue {
    /// A namespace for HTMX attribute value types.
    /// See the [htmx reference](https://htmx.org/reference/) for more information.
    enum HTMX {}
}

public extension HTMLAttributeValue.HTMX {
    struct SwapTarget: RawRepresentable, ExpressibleByStringLiteral {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }

        public static var innerHTML: Self { "innerHTML" }
        public static var outerHTML: Self { "outerHTML" }
        public static var textContent: Self { "textContent" }
        public static var beforeBegin: Self { "beforebegin" }
        public static var afterBegin: Self { "afterbegin" }
        public static var beforEend: Self { "beforeend" }
        public static var afterEnd: Self { "afterend" }
        public static var delete: Self { "delete" }
        public static var none: Self { "none" }
    }

    struct ModifiedSwapTarget: RawRepresentable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(_ swapTarget: SwapTarget) {
            rawValue = swapTarget.rawValue
        }

        public static var innerHTML: Self { .init(.innerHTML) }
        public static var outerHTML: Self { .init(.outerHTML) }
        public static var textContent: Self { .init(.textContent) }
        public static var beforeBegin: Self { .init(.beforeBegin) }
        public static var afterBegin: Self { .init(.afterBegin) }
        public static var beforEend: Self { .init(.beforEend) }
        public static var afterEnd: Self { .init(.afterEnd) }
        public static var delete: Self { .init(.delete) }
        public static var none: Self { .init(.none) }
        public static var `default`: Self { .init("") }
    }
}

public extension HTMLAttributeValue.HTMX.ModifiedSwapTarget {
    consuming func transition(_ value: Bool) -> Self {
        appending(modifier: "transition", value: value.stringValue)
    }

    consuming func swap(_ duration: String) -> Self {
        appending(modifier: "swap", value: duration)
    }

    consuming func settle(_ duration: String) -> Self {
        appending(modifier: "settle", value: duration)
    }

    consuming func ignoreTitle(_ value: Bool) -> Self {
        appending(modifier: "ignoreTitle", value: value.stringValue)
    }

    consuming func scroll(_ value: HTMLAttributeValue.HTMX.ScrollModifier) -> Self {
        appending(modifier: "scroll", value: value.rawValue)
    }

    consuming func show(_ value: HTMLAttributeValue.HTMX.ScrollModifier) -> Self {
        appending(modifier: "show", value: value.rawValue)
    }

    consuming func focusScroll(_ value: Bool) -> Self {
        appending(modifier: "focus-scroll", value: value.stringValue)
    }

    internal consuming func appending(modifier: String, value: String) -> Self {
        if !rawValue.isEmpty {
            rawValue += " "
        }
        rawValue += modifier
        rawValue += ":"
        rawValue += value

        return self
    }
}

public extension HTMLAttributeValue.HTMX {
    struct ScrollModifier: RawRepresentable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var top: Self { .init(rawValue: "top") }
        public static var bottom: Self { .init(rawValue: "bottom") }
        public static var none: Self { .init(rawValue: "none") }

        public static func top(_ selector: String) -> Self {
            .init(rawValue: "\(selector):top")
        }

        public static func bottom(_ selector: String) -> Self {
            .init(rawValue: "\(selector):bottom")
        }
    }
}

public extension HTMLAttributeValue.HTMX {
    struct TriggerEvent: RawRepresentable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var load: Self { .init(rawValue: "load") }
        public static var revealed: Self { .init(rawValue: "revealed") }
        public static var intersect: Self { .init(rawValue: "intersect") }
    }

    struct EventTrigger: RawRepresentable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static func event(_ event: HTMLAttributeValue.MouseEvent) -> Self { .init(rawValue: "\(event.rawValue)") }
        public static func event(_ event: HTMLAttributeValue.KeyboardEvent) -> Self { .init(rawValue: "\(event.rawValue)") }
        public static func event(_ event: HTMLAttributeValue.FormEvent) -> Self { .init(rawValue: "\(event.rawValue)") }
        public static func event(_ event: HTMLAttributeValue.HTMX.TriggerEvent) -> Self { .init(rawValue: "\(event.rawValue)") }
    }

    struct PollingTrigger: RawRepresentable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static func every(_ interval: String) -> Self { .init(rawValue: "every \(interval)") }
    }
}

public extension HTMLAttributeValue.HTMX.EventTrigger {
    consuming func once() -> Self {
        appending(modifier: "once")
    }

    consuming func changed() -> Self {
        appending(modifier: "changed")
    }

    consuming func delay(_ value: String) -> Self {
        appending(modifier: "delay", value: value)
    }

    consuming func throttle(_ value: String) -> Self {
        appending(modifier: "throttle", value: value)
    }

    consuming func from(_ selector: String) -> Self {
        appending(modifier: "from", value: selector)
    }

    consuming func consume() -> Self {
        appending(modifier: "consume")
    }

    internal consuming func appending(modifier: String, value: String? = nil) -> Self {
        rawValue += " "
        rawValue += modifier
        if let value {
            rawValue += ":"
            rawValue += value
        }
        return self
    }
}

public extension HTMLAttributeValue.HTMX {
    struct Extension: RawRepresentable, ExpressibleByStringLiteral {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }
    }
}

extension Bool {
    var stringValue: String { self ? "true" : "false" }
}
