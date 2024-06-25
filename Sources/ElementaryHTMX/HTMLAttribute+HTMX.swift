import Elementary

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    enum hx {}
}

// https://htmx.org/reference/
public extension HTMLAttribute.hx {
    static func get(_ url: String) -> HTMLAttribute {
        .init(name: "hx-get", value: url)
    }

    static func post(_ url: String) -> HTMLAttribute {
        .init(name: "hx-post", value: url)
    }

    static func pushUrl(_ url: String) -> HTMLAttribute {
        .init(name: "hx-push-url", value: url)
    }

    static func pushUrl(_ value: Bool) -> HTMLAttribute {
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

    static func patch(_ url: String) -> HTMLAttribute {
        .init(name: "hx-patch", value: url)
    }

    static func put(_ url: String) -> HTMLAttribute {
        .init(name: "hx-put", value: url)
    }
}
