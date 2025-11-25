import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for HTMX attributes.
    /// See the [htmx reference](https://htmx.org/reference/) for more information.
    public enum hx {}
}

extension HTMLAttribute.hx {
    public static func get(_ url: String) -> HTMLAttribute {
        .init(name: "hx-get", value: url)
    }

    public static func post(_ url: String) -> HTMLAttribute {
        .init(name: "hx-post", value: url)
    }

    public static func pushURL(_ url: String) -> HTMLAttribute {
        .init(name: "hx-push-url", value: url)
    }

    public static func pushURL(_ value: Bool) -> HTMLAttribute {
        .init(name: "hx-push-url", value: value.stringValue)
    }

    public static func select(_ selector: String) -> HTMLAttribute {
        .init(name: "hx-select", value: selector)
    }

    public static func selectOOB(
        _ selector: String, _ swap: HTMLAttributeValue.HTMX.SwapTarget? = nil
    ) -> HTMLAttribute {
        if let swap {
            .init(
                name: "hx-select-oob", value: "\(selector):\(swap.rawValue)",
                mergedBy: .appending(separatedBy: ","))
        } else {
            .init(name: "hx-select-oob", value: selector, mergedBy: .appending(separatedBy: ","))
        }
    }

    public static func swap(_ value: HTMLAttributeValue.HTMX.ModifiedSwapTarget) -> HTMLAttribute {
        .init(name: "hx-swap", value: value.rawValue)
    }

    public static func swapOOB(_ value: Bool) -> HTMLAttribute {
        .init(name: "hx-swap-oob", value: value.stringValue)
    }

    public static func swapOOB(
        _ swap: HTMLAttributeValue.HTMX.SwapTarget, _ selector: String? = nil
    ) -> HTMLAttribute {
        if let selector {
            .init(name: "hx-swap-oob", value: "\(swap.rawValue):\(selector)")
        } else {
            .init(name: "hx-swap-oob", value: swap.rawValue)
        }
    }

    public static func target(_ selector: String) -> HTMLAttribute {
        .init(name: "hx-target", value: selector)
    }

    public static func trigger(_ value: HTMLAttributeValue.HTMX.EventTrigger) -> HTMLAttribute {
        .init(name: "hx-trigger", value: value.rawValue, mergedBy: .appending(separatedBy: ", "))
    }

    public static func trigger(_ value: HTMLAttributeValue.HTMX.PollingTrigger) -> HTMLAttribute {
        .init(name: "hx-trigger", value: value.rawValue, mergedBy: .appending(separatedBy: ", "))
    }

    public static func vals(_ value: String) -> HTMLAttribute {
        .init(name: "hx-vals", value: value)
    }
}

extension HTMLAttribute.hx {
    public static func boost(_ value: Bool) -> HTMLAttribute {
        .init(name: "hx-boost", value: value.stringValue)
    }

    public static func confirm(_ value: String) -> HTMLAttribute {
        .init(name: "hx-confirm", value: value)
    }

    public static func delete(_ url: String) -> HTMLAttribute {
        .init(name: "hx-delete", value: url)
    }

    public static var disable: HTMLAttribute {
        .init(name: "hx-disable", value: .none)
    }

    public static func disabledElt(_ value: String) -> HTMLAttribute {
        .init(name: "hx-disabled-elt", value: value)
    }

    public static func ext(_ value: HTMLAttributeValue.HTMX.Extension) -> HTMLAttribute {
        .init(name: "hx-ext", value: value.rawValue, mergedBy: .appending(separatedBy: ","))
    }

    public static func headers(_ value: String) -> HTMLAttribute {
        .init(name: "hx-headers", value: value)
    }

    public static func include(_ value: String) -> HTMLAttribute {
        .init(name: "hx-include", value: value)
    }

    public static func indicator(_ value: String) -> HTMLAttribute {
        .init(name: "hx-indicator", value: value)
    }

    public static func params(_ value: String) -> HTMLAttribute {
        .init(name: "hx-params", value: value)
    }

    public static func patch(_ url: String) -> HTMLAttribute {
        .init(name: "hx-patch", value: url)
    }

    public static func put(_ url: String) -> HTMLAttribute {
        .init(name: "hx-put", value: url)
    }

    public static func replaceURL(_ url: String) -> HTMLAttribute {
        .init(name: "hx-replace-url", value: url)
    }

    public static func replaceURL(_ value: Bool) -> HTMLAttribute {
        .init(name: "hx-replace-url", value: value.stringValue)
    }

    public static func request(_ value: String) -> HTMLAttribute {
        .init(name: "hx-request", value: value)
    }

    public static func validate(_ value: Bool) -> HTMLAttribute {
        .init(name: "hx-validate", value: value.stringValue)
    }
}
