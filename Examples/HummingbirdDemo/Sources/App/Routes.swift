import AsyncAlgorithms
import Hummingbird
import HummingbirdElementary
import HummingbirdWebSocket
import NIOWebSocket

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
        // parse WebSocket frames
        for try await frame in inbound {
            if frame.opcode == .text, String(buffer: frame.data) == "disconnect", frame.fin == true {
                break
            }
            let opcode: WebSocketOpcode = switch frame.opcode {
            case .text: .text
            case .binary: .binary
            case .continuation: .continuation
            }
            let frame = WebSocketFrame(
                fin: frame.fin,
                opcode: opcode,
                data: frame.data
            )
            try await outbound.write(.text("<div id=\"echo\">Received: \(String(buffer: frame.data))</div>"))
        }
    }
}
