import Foundation
import Hummingbird

@main
struct App {
    static func main() async throws {
        let router = Router(context: URLEncodedRequestContext.self)

        let assetsURL = Bundle.module.resourcePath!.appending("/Public")
        router.middlewares.add(FileMiddleware(assetsURL, searchForIndexHtml: false))

        addRoutes(to: router)

        let app = Application(
            router: router,
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
