import SwiftUI

struct BootScreenView: View {
    @State private var opacity: Double = 0.0
    @State private var scale: CGFloat = 0.7
    @State private var showProgress: Bool = false

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                // ArcFox Logo
                Image(systemName: "pawprint.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hex: "#FF6B35"), Color(hex: "#F7C331")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .scaleEffect(scale)
                    .opacity(opacity)

                Text("ArcFox")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(opacity)

                Text("Initializing system...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .opacity(opacity)

                if showProgress {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white.opacity(0.7)))
                        .scaleEffect(1.2)
                        .padding(.top, 20)
                }

                Spacer()

                Text("ArcFox OS v1.0")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.2))
                    .padding(.bottom, 40)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                opacity = 1.0
                scale = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeIn(duration: 0.4)) {
                    showProgress = true
                }
            }
        }
    }
}

struct BootScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BootScreenView()
    }
}