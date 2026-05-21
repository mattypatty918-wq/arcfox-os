import SwiftUI

struct CrashScreenView: View {
    @EnvironmentObject var bootManager: BootManager

    var body: some View {
        ZStack {
            Color(hex: "0A0A0F")
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color(hex: "FF3B30"))

                Text("System Crash Detected")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text("An unexpected error has occurred.\nPlease restart your device.")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.6))
                    .multilineTextAlignment(.center)

                Button(action: {
                    bootManager.startBoot()
                }) {
                    Text("Reboot System")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 220, height: 50)
                        .background(Color(hex: "FF3B30"))
                        .cornerRadius(25)
                }

                Button(action: {
                    bootManager.powerOff()
                }) {
                    Text("Power Off")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
        }
    }
}