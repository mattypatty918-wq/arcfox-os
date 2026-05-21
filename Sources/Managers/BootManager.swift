import SwiftUI
import Combine

enum DeviceState {
    case off
    case booting
    case locked
    case home
    case crash
}

class BootManager: ObservableObject {
    @Published var deviceState: DeviceState = .off
    @Published var booted = false
    @Published var bootProgress: CGFloat = 0

    private var bootTimer: Timer?
    private var crashTimer: Timer?

    func startBoot() {
        deviceState = .booting
        bootProgress = 0

        bootTimer?.invalidate()
        bootTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }

            self.bootProgress += 0.02

            if self.bootProgress >= 1.0 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.deviceState = .locked
                    self.booted = true
                }
            }
        }
    }

    func powerOff() {
        bootTimer?.invalidate()
        crashTimer?.invalidate()
        deviceState = .off
        booted = false
        bootProgress = 0
    }

    func triggerCrash() {
        bootTimer?.invalidate()
        crashTimer?.invalidate()
        deviceState = .crash
    }

    func lock() {
        if deviceState == .home {
            deviceState = .locked
        }
    }

    func unlock() {
        if deviceState == .locked {
            deviceState = .home
        }
    }
}