import SwiftUI

@main
struct ArcFoxApp: App {
    @StateObject private var bootManager = BootManager()
    @State private var showBootScreen = true

    var body: some Scene {
        WindowGroup {
            if showBootScreen {
                BootScreenView()
                    .environmentObject(bootManager)
                    .onReceive(bootManager.$booted) { booted in
                        if booted {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showBootScreen = false
                            }
                        }
                    }
            } else {
                RootView()
                    .environmentObject(bootManager)
            }
        }
    }
}