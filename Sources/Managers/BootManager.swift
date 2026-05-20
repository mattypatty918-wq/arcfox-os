import Foundation
import SwiftUI
import Combine

enum SystemPhase: Equatable {
    case off
    case booting
    case lockscreen
    case home
    case crashed
}

class BootManager: ObservableObject {
    @Published var phase: SystemPhase = .booting

    private var bootTimer: Timer?

    init() {
        startBoot()
    }

    func startBoot() {
        phase = .off
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.phase = .booting
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.phase = .lockscreen
            }
        }
    }

    func unlock() {
        withAnimation(.easeInOut(duration: 0.5)) {
            phase = .home
        }
    }

    func lock() {
        withAnimation(.easeInOut(duration: 0.3)) {
            phase = .lockscreen
        }
    }

    func shutdown() {
        withAnimation(.easeInOut(duration: 0.5)) {
            phase = .off
        }
    }

    func crash() {
        phase = .crashed
    }

    func reboot() {
        phase = .booting
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.phase = .lockscreen
        }
    }
}