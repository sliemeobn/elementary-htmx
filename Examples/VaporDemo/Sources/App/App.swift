import Vapor

@main
struct App {
    static func main() async throws {
        let app = try await Application.make()
        try app.middleware.use(FileMiddleware(bundle: .module))

        addRoutes(to: app)

        #if DEBUG
        app.lifecycle.use(BrowserSyncHandler())
        #endif

        try await app.execute()
    }
}
