import Elementary
import ElementaryHTMX
import Foundation
import Hummingbird
import HummingbirdElementary

func addRoutes(to router: Router<some RequestContext>) {
    router.get("") { _, _ in
        let model = await Database.shared.model

        return HTMLResponse {
            MainPage(model: model)
        }
    }

    router.get("/time") { _, _ in
        let stream = AsyncThrowingStream(ByteBuffer.self) { continuation in
            Task {
                while true {
                    // guard let data = try Event(event: "time", data: "\(Date())").toJSON()
                    // else { break }
                    let data = "event: time\ndata: \(Date()) \n\n"
                    continuation.yield(.init(bytes: data.utf8))
                    print("again")
                    try await Task.sleep(nanoseconds: 3_000_000_000)
                    break
                }
                continuation.finish()
            }
        }
        let res = Response(status: .ok, headers: [.contentType: "text/event-"], body: .init(asyncSequence: stream))
        print(res)
        return res
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
