import SwiftUI

struct RootView: View {
    @EnvironmentObject var bootManager: BootManager

    var body: some View {
        ZStack {
            switch bootManager.deviceState {
            case .off:
                PowerOffView()
            case .booting:
                BootScreenView()
            case .locked:
                LockScreenView()
            case .home:
                HomeScreenView()
            case .crash:
                CrashScreenView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: bootManager.deviceState)
    }
}