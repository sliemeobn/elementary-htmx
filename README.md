# ElementaryHTMX: Hypertext web apps with Swift

**Ergonomic [HTMX](https://htmx.org/) extensions for [Elementary](https://github.com/sliemeobn/elementary)**

```swift
import Elementary
import ElementaryHTMX

form(.hx.post("/items"), .hx.target("#list"), .hx.swap(.outerHTML)) {
    input(.type(.text), .name("item"), .value("New Item"))
    input(.type(.submit), .value("Add Item"))
}

div {
    button(.hx.delete("items/\(item.id)")) { "❌" }
    item.text
}

MyFragment(items: items)
    .attributes(.hx.swapOOB(.outerHTML, "#list"))
```

## Play with it

Check out the [Hummingbird example app](https://github.com/sliemeobn/elementary-htmx/tree/main/Examples/HummingbirdDemo).

## Documentation

The package brings the `.hx` syntaxt to all `HTMLElements` - providing a rich API for most [HTMX attributes](https://htmx.org/docs/).

## Future directions

- Add module for [Server Sent Events extensions](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/sse/README.md)
- Add module for [WebSockets extension](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/ws/README.md)
- Add module (or separate package?) for HTMX Request and Response headers

PRs welcome.
