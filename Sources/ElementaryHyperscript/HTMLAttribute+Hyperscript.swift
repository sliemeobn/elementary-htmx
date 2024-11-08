import Elementary

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    static func hs(_ script: String) -> HTMLAttribute {
        .init(name: "_", value: script)
    }
}
