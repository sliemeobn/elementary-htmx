import Foundation
import Vapor

#if DEBUG
    struct BrowserSyncHandler: LifecycleHandler {
        func didBoot(_: Application) throws {
            let p = Process()
            p.executableURL = URL(string: "file:///bin/sh")
            p.arguments = ["-c", "browser-sync reload"]
            do {
                try p.run()
            } catch {
                print("Could not auto-reload: \(error)")
            }
        }
    }
#endif
