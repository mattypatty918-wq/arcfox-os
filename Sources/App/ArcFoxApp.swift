import SwiftUI

@main
struct ArcFoxApp: App {
    @StateObject private var bootManager = BootManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(bootManager)
                .preferredColorScheme(.dark)
                .statusBarHidden(true)
        }
    }
}