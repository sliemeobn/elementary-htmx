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
}
