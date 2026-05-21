import SwiftUI

struct LockScreenView: View {
    @EnvironmentObject var bootManager: BootManager
    @State private var showTime = true
    @State private var unlocked = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "1A1A2E"),
                    Color(hex: "16213E")
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                if showTime {
                    VStack(spacing: 10) {
                        Text("12:30")
                            .font(.system(size: 72, weight: .thin, design: .rounded))
                            .foregroundColor(.white)

                        Text("Wednesday, May 20")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .transition(.opacity)
                }

                Spacer()

                Button(action: {
                    withAnimation(.spring(response: 0.3)) {
                        unlocked = true
                        bootManager.unlock()
                    }
                }) {
                    VStack(spacing: 8) {
                        Image(systemName: "lock.open.fill")
                            .font(.system(size: 28))
                        Text("Slide to Unlock")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .foregroundColor(.white)
                    .frame(width: 280, height: 60)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                }
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                showTime = true
            }
        }
    }
}