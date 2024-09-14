import Elementary
import ElementaryHTMXSSE
import ElementaryHTMXWS
import Foundation

struct MainPage: HTMLDocument {
    var title: String { "Hummingbird + Elementary + HTMX" }

    var model: Model

    var head: some HTML {
        meta(.charset(.utf8))
        script(.src("/htmx.min.js")) {}
        script(.src("/htmxsse.min.js")) {}
        script(.src("/htmxws.min.js")) {}
        link(.href("/pico.min.css"), .rel(.stylesheet))
    }

    var body: some HTML {
        header(.class("container")) {
            h2 { "Hummingbird + Elementary + HTMX Demo" }
            // example of using htmx sse
            div(.hx.ext(.sse), .sse.connect("/time"), .sse.swap("message")) {
                TimeHeading()
            }
            // example of using htmx ws
            div(.hx.ext(.ws), .ws.connect("/echo"), .hx.vals("{ \"value\": \"TestValue\"}"), .hx.swapOOB(.innerHTML), .hx.target("#echo"), .class("flex justify-between")) {
                button(.ws.send, .class("btn btn-primary")) { "Send" }
                span(.id("echo"), .hx.swapOOB(.innerHTML)) {}
            }
        }
        main(.class("container")) {
            div {
                // example of using hx-target and hx-swap
                form(.hx.post("/items"), .hx.target("#list"), .hx.swap(.outerHTML)) {
                    div(.class("grid")) {
                        input(.type(.text), .name("item"), .value("New Item"), .required)
                        input(.type(.submit), .value("Add Item"))
                    }
                }
            }
            ItemList(items: model.items)
        }
    }
}

struct ItemList: HTML {
    var items: [String]

    var content: some HTML<HTMLTag.div> {
        div(.id("list")) {
            h4 { "Items" }
            p { "Count: \(items.count)" }

            for (index, item) in items.enumerated() {
                div {
                    // this hx-delete will use OOB swap
                    button(.hx.delete("items/\(index)")) { "X" }
                    " "
                    item
                }
            }
        }
    }
}

struct TimeHeading: HTML {
    var content: some HTML<HTMLTag.h4> {
        h4 {
            "Server Time: \(Date())"
        }
    }
}
