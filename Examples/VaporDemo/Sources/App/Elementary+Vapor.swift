import Elementary
import Vapor

struct HTMLResponse<Content: HTML> {
    @HTMLBuilder var content: Content
}

struct HTMLBodyStreamWriter: HTMLStreamWriter {
    var writer: any AsyncBodyStreamWriter
    var allocator: ByteBufferAllocator

    func write(_ bytes: ArraySlice<UInt8>) async throws {
        try await writer.writeBuffer(allocator.buffer(bytes: bytes))
    }
}

extension HTMLResponse: Vapor.AsyncResponseEncodable {
    func encodeResponse(for request: Request) async throws -> Response {
        Response(
            status: .ok,
            headers: ["Content-Type": "text/html"],
            body: .init(asyncStream: { writer in
                try await content.render(into: HTMLBodyStreamWriter(writer: writer, allocator: request.byteBufferAllocator))
                try await writer.write(.end)
            })
        )
    }
}
