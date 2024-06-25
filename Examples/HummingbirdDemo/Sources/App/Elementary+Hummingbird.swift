import Elementary
import Hummingbird

struct HTMLResponse<Content: HTML> {
    @HTMLBuilder var content: Content
}

extension HTMLResponse: ResponseGenerator {
    func response(from request: Request, context: some RequestContext) throws -> Response {
        .init(
            status: .ok,
            headers: [.contentType: "text/html"],
            body: .init(byteBuffer: .init(string: content.render()))
        )
    }
}
