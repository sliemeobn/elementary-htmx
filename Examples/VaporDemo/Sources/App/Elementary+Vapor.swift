import Elementary
import Vapor

struct HTMLResponse<Content: HTML> {
    @HTMLBuilder var content: Content
}

extension HTMLResponse: Vapor.AsyncResponseEncodable {
    func encodeResponse(for request: Request) async throws -> Response {
        Response(
            status: .ok,
            headers: ["Content-Type": "text/html"],
            body: .init(string: content.render())
        )
    }
}
