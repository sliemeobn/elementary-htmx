import Elementary
import ElementaryHTMX
import ElementaryHTMXSSE
import ElementaryHTMXWS
import Foundation

struct MainPage: HTMLDocument {
    var title: String { "Vapor + Elementary + HTMX" }

    var head: some HTML {
        meta(.charset(.utf8))
        script(.src("/htmx.min.js")) {}
        script(.src("/htmxsse.min.js")) {}
        script(.src("/htmxws.min.js")) {}
        link(
            .rel(.stylesheet),
            .href("https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.classless.min.css"))
    }

    var body: some HTML {
        header {
            h2 { "Vapor + Elementary + HTMX Demo" }
            // example of using htmx sse
            h6 { "HTMX SSE Example" }
            div(.hx.ext(.sse), .sse.connect("/time")) {
                p(.sse.swap("time")) { "Server Time:" }
            }
        }
        main {
            h6 { "HTMX Forms Example" }
            div {
                // example of using hx-target and hx-swap
                form(.hx.get("/result"), .hx.target("#result"), .hx.swap(.innerHTML)) {
                    fieldset(.custom(name: "role", value: "group")) {
                        input(.type(.number), .name("x"), .value("1"), .required)
                        input(.type(.text), .value("+"), .disabled)
                        input(.type(.number), .name("y"), .value("2"), .required)
                        input(.type(.submit), .value("Calculate"))
                    }
                }
            }
            div(.id("result")) {
                p { i { "Result will be calculated on the server" } }
            }
            hr()
            h6 { "HTMX WS Example" }
            // example of using htmx ws
            div(.hx.ext(.ws), .ws.connect("/echo")) {
                form(.ws.send, .custom(name: "role", value: "group")) {
                    input(.type(.text), .name("message"), .value("Hello, World!"), .required)
                    button { "Send" }
                }
                div(.id("echo")) {}
            }
        }
    }
}

struct ResultView: HTML {
    let x: Int
    let y: Int

    @Environment(requiring: BonusFactStore.$current) var bonusFacts

    var body: some HTML {
        p {
            "\(x) + \(y) = "
            b { "\(x + y)" }
        }
        p {
            i {
                await bonusFacts.calculateBonusFact()
            }
        }
    }
}

struct WSEcho: HTML {
    let message: String

    var body: some HTML {
        div(.id("echo"), .hx.swapOOB(.beforeEnd)) {
            "Echo: \(message)"
            br()
        }
    }
}
