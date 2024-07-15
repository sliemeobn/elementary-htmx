import AsyncAlgorithms
import Elementary
import ElementaryHTMX
import Foundation
import Hummingbird
import HummingbirdElementary
import ServiceLifecycle

func addRoutes(to router: Router<some RequestContext>) {
    router.get("") { _, _ in
        let model = await Database.shared.model

        return HTMLResponse {
            MainPage(model: model)
        }
    }

    router.get("/time") { _, _ in
        let timerSequence = AsyncTimerSequence(interval: .seconds(1), clock: ContinuousClock())
            .map { _ in
                ByteBuffer(bytes: "event:time\ndata: \(Date())\n\n".utf8)
            }
            .cancelOnGracefulShutdown()
        return Response.stream(timerSequence)
    }

    router.post("/items") { request, context in
        let body = try await request.decode(as: AddItemRequest.self, context: context)
        await Database.shared.addItem(body.item)
        let items = await Database.shared.model.items

        return HTMLResponse {
            ItemList(items: items)
        }
    }

    router.delete("items/{index}") { _, context in
        guard let index = context.parameters.get("index", as: Int.self) else {
            throw HTTPError(.badRequest)
        }

        let wasRemoved = await Database.shared.removeItem(at: index)

        guard wasRemoved else {
            throw HTTPError(.notFound)
        }

        let items = await Database.shared.model.items

        return HTMLResponse {
            // exmple of using OOB swaps
            ItemList(items: items)
                .attributes(.hx.swapOOB(.outerHTML, "#list"))
        }
    }
}

struct AddItemRequest: Decodable {
    var item: String
}

struct Event: Encodable {
    var event: String
    var data: String
}

public extension Response {
    static func stream<BufferSequence: AsyncSequence & Sendable>(_ asyncSequence: BufferSequence) -> Response where BufferSequence.Element == ByteBuffer {
        .init(status: .ok, headers: [.contentType: "text/event-stream"], body: .init(asyncSequence: asyncSequence))
    }
}
