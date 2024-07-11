import Elementary
import ElementaryHTMX
import ElementaryHxSSE

struct MainPage: HTMLDocument {
    var title: String { "Vapor + Elementary + HTMX" }

    var head: some HTML {
        meta(.charset(.utf8))
        script(.src("/htmx.min.js")) {}
        script(.src("https://unpkg.com/htmx-ext-sse@2.0.0/sse.js")) {}
    }

    var body: some HTML {
        header {
            h2 { "Vapor + Elementary + HTMX" }
            div(.hx.sse.ext(), .hx.sse.connect("/time"), .hx.swap(.innerHTML)) {
                div(.hx.sse.swap("time")) {
                    "waiting...."
                }
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
