import Hummingbird

func addRoutes(to router: Router<some RequestContext>) {
    router.get("") { _, _ in
        let model = await Database.shared.model

        return HTMLResponse {
            MainPage(model: model)
        }
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
