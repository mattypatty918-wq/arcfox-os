import SwiftUI

struct PowerOffView: View {
    @EnvironmentObject var bootManager: BootManager

    var body: some View {
        ZStack {
            Color(hex: "0A0A0F")
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Image(systemName: "power")
                    .font(.system(size: 60))
                    .foregroundColor(.white.opacity(0.3))

                Text("Hold power button to start")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.4))

                Button(action: {
                    bootManager.startBoot()
                }) {
                    Text("Power On")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(
                            LinearGradient(
                                colors: [Color(hex: "6366F1"), Color(hex: "8B5CF6")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(25)
                        .shadow(color: Color(hex: "6366F1").opacity(0.4), radius: 15)
                }
            }
        }
    }
}