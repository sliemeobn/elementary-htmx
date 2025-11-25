import Foundation
import Hummingbird
import HummingbirdWSCompression
import HummingbirdWebSocket

@main
struct App {
    static func main() async throws {
        let router = Router(context: URLEncodedRequestContext.self)

        let assetsURL = Bundle.module.resourcePath!.appending("/Public")
        router.middlewares.add(FileMiddleware(assetsURL, searchForIndexHtml: false))

        addRoutes(to: router)

        let wsRouter = Router(context: BasicWebSocketRequestContext.self)
        addWSRoutes(to: wsRouter)

        let app = Application(
            router: router,
            server: .http1WebSocketUpgrade(webSocketRouter: wsRouter, configuration: .init(extensions: [.perMessageDeflate()])),
            onServerRunning: { _ in
                print("Server running on http://localhost:8080/")
                #if DEBUG
                browserSyncReload()
                #endif
            }
        )
        try await app.runService()
    }
}

struct URLEncodedRequestContext: RequestContext {
    var coreContext: CoreRequestContextStorage

    init(source: ApplicationRequestContextSource) {
        coreContext = .init(source: source)
    }

    var requestDecoder: URLEncodedFormDecoder { .init() }
}
