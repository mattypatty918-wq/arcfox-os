import SwiftUI

struct BootScreenView: View {
    @EnvironmentObject var bootManager: BootManager

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "0A0A0F"),
                    Color(hex: "1A1A2E")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 40) {
                Spacer()

                // Logo
                Image(systemName: "aqi.medium")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .shadow(color: Color(hex: "6366F1").opacity(0.5), radius: 30)

                Text("ArcFox OS")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Spacer()

                // Progress bar
                VStack(spacing: 12) {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.white.opacity(0.1))
                                .frame(height: 4)

                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(hex: "6366F1"), Color(hex: "8B5CF6")],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: geometry.size.width * bootManager.bootProgress, height: 4)
                        }
                    }
                    .frame(width: 200, height: 4)

                    Text("Loading...")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                }

                Spacer()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            bootManager.startBoot()
        }
    }
}