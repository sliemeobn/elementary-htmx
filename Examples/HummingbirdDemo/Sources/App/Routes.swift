import AsyncAlgorithms
import Hummingbird
import HummingbirdElementary

func addRoutes(to router: Router<some RequestContext>) {
    router.get("") { _, _ in
        HTMLResponse {
            MainPage()
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

        return HTMLResponse {
            ItemList()
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

        return HTMLResponse {
            // exmple of using OOB swaps
            ItemList()
                .attributes(.hx.swapOOB(.outerHTML, "#list"))
        }
    }
}

struct AddItemRequest: Decodable {
    var item: String
}
