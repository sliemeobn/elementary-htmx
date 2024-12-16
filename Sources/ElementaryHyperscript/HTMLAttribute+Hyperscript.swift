import Elementary

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    static func hyperscript(_ script: String) -> Self {
        .init(name: "_", value: script)
    }
}
