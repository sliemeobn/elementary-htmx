import AsyncAlgorithms
import Foundation
import Hummingbird
import HummingbirdElementary
import HummingbirdWebSocket
import NIOWebSocket
import ElementaryHTMX

func addRoutes(to router: Router<some RequestContext>) {
    router.get("") { _, _ in
        let model = await Database.shared.model

        return HTMLResponse {
            MainPage(model: model)
        }
    }

    router.get("/time") { _, _ in
        Response(
            status: .ok,
            headers: [.contentType: "text/event-stream"],
            body: .init { writer in
                for await _ in AsyncTimerSequence.repeating(every: .seconds(1)).cancelOnGracefulShutdown() {
                    try await writer.write(ByteBuffer(string: "data: \(TimeHeading().render())\n\n"))
                }
                try await writer.finish(nil)
            }
        )
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

func addWSRoutes(to router: Router<some WebSocketRequestContext>) {
    router.ws("echo") { _, _ in
        .upgrade([:])
    } onUpgrade: { inbound, outbound, _ in
        for try await input in inbound.messages(maxSize: 1_000_000) {
            guard case let .text(text) = input else { continue }
            let echoRequest = try JSONDecoder().decode(EchoRequest.self, from: text.data(using: .utf8)!)
            try await outbound.write(.text(WSResponse(echoRequest: echoRequest).render()))
        }
    }
}

struct EchoRequest: Codable {
    var message: String
    var headers: HTMXHeaders

    enum CodingKeys: String, CodingKey {
        case message
        case headers = "HEADERS"
    }
}

struct HTMXHeaders: Codable {
    var HXRequest: String
    var HXTrigger: String?
    var HXTriggerName: String?
    var HXTarget: String
    var HXCurrentURL: String?

    enum CodingKeys: String, CodingKey {
        case HXRequest = "HX-Request"
        case HXTrigger = "HX-Trigger"
        case HXTriggerName = "HX-Trigger-Name"
        case HXTarget = "HX-Target"
        case HXCurrentURL = "HX-Current-URL"
    }
}