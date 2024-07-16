import Elementary
import Hummingbird
import HummingbirdElementary
import ServiceLifecycle

public extension Response {
    static func stream<BufferSequence: AsyncSequence & Sendable>(_ asyncSequence: BufferSequence) -> Response where BufferSequence.Element == ByteBuffer {
        .init(status: .ok, headers: [.contentType: "text/event-stream"], body: .init(asyncSequence: asyncSequence.cancelOnGracefulShutdown()))
    }

    static func stream<BufferSequence: AsyncSequence & Sendable>(_ asyncSequence: BufferSequence, eventName: String? = nil) -> Response where BufferSequence.Element: HTML {
        let eventStream = asyncSequence.map { html in
            ByteBuffer(bytes: "\(eventName != nil ? "event:\(eventName!)\n" : "")data:\(html.render())\n\n".utf8)
        }
        return .stream(eventStream)
    }
}
