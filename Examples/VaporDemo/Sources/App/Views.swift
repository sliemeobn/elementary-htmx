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
    }

    var body: some HTML {
        header {
            h2 { "Vapor + Elementary + HTMX Demo" }
            // example of using htmx sse
            div(.hx.ext(.sse), .sse.connect("/time")) {
                p(.sse.swap("time")) { "Server Time:" }
            }
            // example of using htmx ws
            div(.hx.ext(.ws), .ws.connect("/echo"), .hx.vals("{ \"value\": \"TestValue\"}"), .hx.swapOOB(.innerHTML), .hx.target("#echo"), .class("flex justify-between")) {
                button(.ws.send, .class("btn btn-primary")) { "Send" }
                span(.id("echo"), .hx.swapOOB(.innerHTML)) {}
            }
        }
        main {
            div {
                // example of using hx-target and hx-swap
                form(.hx.get("/result"), .hx.target("#result"), .hx.swap(.innerHTML)) {
                    div(.class("grid")) {
                        input(.type(.number), .name("x"), .value("1"), .required)
                        span { " + " }
                        input(.type(.number), .name("y"), .value("2"), .required)
                        input(.type(.submit), .value("Calculate"))
                    }
                }
            }
            div(.id("result")) {
                p { i { "Result will be calculated on the server" } }
            }
        }
    }
}

struct ResultView: HTML {
    let x: Int
    let y: Int

    var content: some HTML {
        p {
            "\(x) + \(y) = "
            b { "\(x + y)" }
        }
    }
}
