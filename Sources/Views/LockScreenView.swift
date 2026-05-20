import SwiftUI

struct LockScreenView: View {
    @EnvironmentObject var bootManager: BootManager
    @State private var dragOffset: CGFloat = 0.0
    @State private var unlockIconOpacity: Double = 0.3
    @State private var currentTime = Date()
    @State private var isUnlocking = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [Color(hex: "#0f0c29"), Color(hex: "#302b63"), Color(hex: "#24243e")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                // Clock
                VStack(spacing: 8) {
                    Text(currentTime, format: .dateTime.hour().minute())
                        .font(.system(size: 78, weight: .thin, design: .rounded))
                        .foregroundColor(.white)
                        .contentTransition(.numericText())

                    Text(currentTime, format: .dateTime.weekday(.wide).month().day())
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .contentTransition(.numericText())
                }

                Spacer()

                // Unlock indicator
                VStack(spacing: 12) {
                    // Animated chevron
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.up")
                            .font(.title3)
                            .foregroundColor(.white.opacity(unlockIconOpacity))
                        Image(systemName: "chevron.up")
                            .font(.title3)
                            .foregroundColor(.white.opacity(unlockIconOpacity * 0.6))
                        Image(systemName: "chevron.up")
                            .font(.title3)
                            .foregroundColor(.white.opacity(unlockIconOpacity * 0.3))
                    }
                    .offset(y: dragOffset)

                    Text("Swipe up to unlock")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.6))
                }
                .offset(y: dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height < 0 {
                                dragOffset = value.translation.height
                                unlockIconOpacity = min(1.0, 0.3 - (value.translation.height / 200))
                            }
                        }
                        .onEnded { value in
                            if value.translation.height < -80 {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    isUnlocking = true
                                    bootManager.unlock()
                                }
                            } else {
                                withAnimation(.spring(response: 0.4)) {
                                    dragOffset = 0
                                    unlockIconOpacity = 0.3
                                }
                            }
                        }
                )
                .padding(.bottom, 50)
            }
        }
        .onReceive(timer) { _ in
            currentTime = Date()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                unlockIconOpacity = 1.0
            }
        }
    }
}

struct LockScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenView()
            .environmentObject(BootManager())
    }
}