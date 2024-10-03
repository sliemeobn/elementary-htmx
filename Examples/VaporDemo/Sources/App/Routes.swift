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
                .environment(BonusFactStore.$current, BonusFactStore())
        }
    }

    app.get("time") { _ -> Response in
        Response(
            status: .ok,
            headers: ["Content-Type": "text/event-stream"],
            body: .init(managedAsyncStream: { writer in
                while true {
                    try await writer.writeBuffer(.init(string: "event: time\ndata: Server Time: \(Date())\n\n"))
                    try await Task.sleep(for: .seconds(1))
                }
            })
        )
    }

    app.webSocket("echo") { _, ws in
        let decoder = JSONDecoder()

        ws.onText { ws, text in
            guard let message = try? decoder.decode(WSMessage.self, from: Data(text.utf8)) else {
                return
            }

            ws.send(WSEcho(message: message.message).render())
        }
    }
}

struct WSMessage: Codable {
    var message: String
}
