import SwiftUI

struct RootView: View {
    @EnvironmentObject var bootManager: BootManager

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            switch bootManager.phase {
            case .off:
                PowerOffView()
                    .transition(.opacity)

            case .booting:
                BootScreenView()
                    .transition(.opacity)

            case .lockscreen:
                LockScreenView()
                    .transition(.opacity)

            case .home:
                HomeScreenView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom),
                        removal: .move(edge: .top)
                    ))

            case .crashed:
                CrashScreenView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: bootManager.phase)
    }
}