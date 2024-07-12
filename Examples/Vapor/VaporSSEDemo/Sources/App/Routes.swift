import Vapor
import VaporElementary

func addRoutes(to app: Application) {
    app.get("") { _ in
        HTMLResponse {
            MainPage()
        }
    }

    app.get("result") { request in
        let x = try request.query.get(Int.self, at: "x")
        let y = try request.query.get(Int.self, at: "y")
        return HTMLResponse {
            ResultView(x: x, y: y)
        }
    }

    app.get("time") { req -> Response in
        let body = Response.Body(stream: { writer in
            Task {
                do {
                    while true {
                        let data = "event: time\ndata: \(Date()) \n\n"
                        _ = writer.write(.buffer(.init(string: data)))
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                    }
                } catch {
                    req.logger.error("Stream Error: \(error)")
                    // _ = writer.write(.error(error)) // writing error would crash the app
                }
                _ = writer.write(.end)
            }
        })
        let res = Response(status: .ok, body: body)
        res.headers.replaceOrAdd(name: "Content-Type", value: "text/event-stream")
        return res
    }
}

struct Event: Encodable {
    var event: String
    var data: String
}
