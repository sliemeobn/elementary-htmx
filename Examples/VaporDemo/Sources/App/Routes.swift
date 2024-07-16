import AsyncAlgorithms
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

    app.get("time") { request -> Response in
        let body = Response.Body(stream: { writer in
            request.eventLoop.scheduleRepeatedTask(initialDelay: .seconds(1), delay: .seconds(1)) { _ in
                try writer.write(.buffer(.init(string: "event: time\ndata: Server Time: \(Date())\n\n")), promise: nil)
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
