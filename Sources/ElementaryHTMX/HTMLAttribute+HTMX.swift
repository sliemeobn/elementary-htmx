import Elementary

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for HTMX attributes.
    /// See the [htmx reference](https://htmx.org/reference/) for more information.
    enum hx {}
}

public extension HTMLAttribute.hx {
    static func get(_ url: String) -> HTMLAttribute {
        .init(name: "hx-get", value: url)
    }

    static func post(_ url: String) -> HTMLAttribute {
        .init(name: "hx-post", value: url)
    }

    static func pushURL(_ url: String) -> HTMLAttribute {
        .init(name: "hx-push-url", value: url)
    }

    static func pushURL(_ value: Bool) -> HTMLAttribute {
        .init(name: "hx-push-url", value: value.stringValue)
    }

    static func select(_ selector: String) -> HTMLAttribute {
        .init(name: "hx-select", value: selector)
    }

    static func selectOOB(_ selector: String, _ swap: HTMLAttributeValue.HTMX.SwapTarget? = nil) -> HTMLAttribute {
        if let swap {
            .init(name: "hx-select-oob", value: "\(selector):\(swap.rawValue)", mergedBy: .appending(seperatedBy: ","))
        } else {
            .init(name: "hx-select-oob", value: selector, mergedBy: .appending(seperatedBy: ","))
        }
    }

    static func swap(_ value: HTMLAttributeValue.HTMX.ModifiedSwapTarget) -> HTMLAttribute {
        .init(name: "hx-swap", value: value.rawValue)
    }

    static func swapOOB(_ value: Bool) -> HTMLAttribute {
        .init(name: "hx-swap-oob", value: value.stringValue)
    }

    static func swapOOB(_ swap: HTMLAttributeValue.HTMX.SwapTarget, _ selector: String? = nil) -> HTMLAttribute {
        if let selector {
            .init(name: "hx-swap-oob", value: "\(swap.rawValue):\(selector)")
        } else {
            .init(name: "hx-swap-oob", value: swap.rawValue)
        }
    }

    static func target(_ selector: String) -> HTMLAttribute {
        .init(name: "hx-target", value: selector)
    }

    static func trigger(_ value: HTMLAttributeValue.HTMX.EventTrigger) -> HTMLAttribute {
        .init(name: "hx-trigger", value: value.rawValue, mergedBy: .appending(seperatedBy: ", "))
    }

    static func trigger(_ value: HTMLAttributeValue.HTMX.PollingTrigger) -> HTMLAttribute {
        .init(name: "hx-trigger", value: value.rawValue, mergedBy: .appending(seperatedBy: ", "))
    }

    static func vals(_ value: String) -> HTMLAttribute {
        .init(name: "hx-vals", value: value)
    }
}

public extension HTMLAttribute.hx {
    static func boost(_ value: Bool) -> HTMLAttribute {
        .init(name: "hx-boost", value: value.stringValue)
    }

    static func confirm(_ value: String) -> HTMLAttribute {
        .init(name: "hx-confirm", value: value)
    }

    static func delete(_ url: String) -> HTMLAttribute {
        .init(name: "hx-delete", value: url)
    }

    static var disable: HTMLAttribute {
        .init(name: "hx-disable", value: .none)
    }

    static func disabledElt(_ value: String) -> HTMLAttribute {
        .init(name: "hx-disabled-elt", value: value)
    }

    static func ext(_ value: String) -> HTMLAttribute {
        .init(name: "hx-ext", value: value, mergedBy: .appending(seperatedBy: ","))
    }

    static func headers(_ value: String) -> HTMLAttribute {
        .init(name: "hx-headers", value: value)
    }

    static func include(_ value: String) -> HTMLAttribute {
        .init(name: "hx-include", value: value)
    }

    static func indicator(_ value: String) -> HTMLAttribute {
        .init(name: "hx-indicator", value: value)
    }

    static func params(_ value: String) -> HTMLAttribute {
        .init(name: "hx-params", value: value)
    }

    static func patch(_ url: String) -> HTMLAttribute {
        .init(name: "hx-patch", value: url)
    }

    static func put(_ url: String) -> HTMLAttribute {
        .init(name: "hx-put", value: url)
    }

    static func replaceURL(_ url: String) -> HTMLAttribute {
        .init(name: "hx-replace-url", value: url)
    }

    static func replaceURL(_ value: Bool) -> HTMLAttribute {
        .init(name: "hx-replace-url", value: value.stringValue)
    }

    static func request(_ value: String) -> HTMLAttribute {
        .init(name: "hx-request", value: value)
    }

    static func validate(_ value: Bool) -> HTMLAttribute {
        .init(name: "hx-validate", value: value.stringValue)
    }
}
