# ElementaryHTMX: Hypertext web apps with Swift

**Ergonomic [HTMX](https://htmx.org/) extensions for [Elementary](https://github.com/sliemeobn/elementary)**

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsliemeobn%2Felementary-htmx%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sliemeobn/elementary-htmx) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsliemeobn%2Felementary-htmx%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sliemeobn/elementary-htmx)

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
Check out the [Vapor example app](https://github.com/sliemeobn/elementary-htmx/tree/main/Examples/VaporDemo).

## Documentation

The package brings the `.hx` syntaxt to all `HTMLElements` - providing a rich API for most [HTMX attributes](https://htmx.org/docs/).

## Future directions

- Add module for [Server Sent Events extensions](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/sse/README.md)
- Add module for [WebSockets extension](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/ws/README.md)
- Add module (or separate package?) for HTMX Request and Response headers

PRs welcome.
