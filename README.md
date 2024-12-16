# ElementaryHTMX: Hypertext web apps with Swift

**Ergonomic [HTMX](https://htmx.org/) extensions for [Elementary](https://github.com/sliemeobn/elementary)**

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsliemeobn%2Felementary-htmx%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sliemeobn/elementary-htmx) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsliemeobn%2Felementary-htmx%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sliemeobn/elementary-htmx)

```swift
import Elementary
import ElementaryHTMX

// first-class support for all HTMX attributes
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

```swift
import Elementary
import ElementaryHTMXSSE

// HTMX Server Send Events extension
div(.hx.ext(.sse), .sse.connect("/time"), .sse.swap("message")) {
    Date()
}
```

```swift
import Elementary
import ElementaryHTMXWS

// HTMX WebSockets extension
div(.hx.ext(.ws), .ws.connect("/echo")) {
    form(.ws.send) {
        input(.type(.text), .name("message"))
        button { "Send" }
    }
    div(.id("echo")) {}
}
```

```swift
import Elementary
import ElementaryHyperscript

// Hyperscript extension
button(.hyperscript("on click send hello to <form />")) {
    "Send"
}
```

## Play with it

Check out the [Hummingbird example app](https://github.com/sliemeobn/elementary-htmx/tree/main/Examples/HummingbirdDemo).

Check out the [Vapor example app](https://github.com/sliemeobn/elementary-htmx/tree/main/Examples/VaporDemo).

## Documentation

The package brings the `.hx` syntaxt to all `HTMLElements` - providing a rich API for most [HTMX attributes](https://htmx.org/docs/).

There is also an `ElementaryHTMXSSE` module that adds the `.sse` syntax for the [Server Sent Events extensions](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/sse/README.md), as well as `ElementaryHTMXWS` to add the `.ws` syntax for the [WebSockets extensions.](https://github.com/bigskysoftware/htmx-extensions/blob/main/src/ws/README.md)

The package also supports the [Hyperscript](https://hyperscript.org) `_` attribute as `.hyperscript`.

## Future directions

- Add module (or separate package?) for HTMX Request and Response headers

PRs welcome.
