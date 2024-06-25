import Elementary
import ElementaryHTMX

struct MainPage: HTMLDocument {
    var title: String { "Hummingbird + Elementary + HTMX" }

    var model: Model

    var head: some HTML {
        script(.src("/htmx.min.js")) {}
    }

    var body: some HTML {
        h1 { "Hummingbird + Elementary + HTMX Demo" }
        main {
            div {
                // example of using hx-target and hx-swap
                form(.hx.post("/items"), .hx.target("#list"), .hx.swap(.outerHTML)) {
                    input(.type(.text), .name("item"), .value("New Item"))
                    input(.type(.submit), .value("Add Item"))
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
                    button(.hx.delete("items/\(index)")) { "❌" }
                    " "
                    item
                }
            }
        }
    }
}
