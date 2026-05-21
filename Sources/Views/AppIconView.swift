import SwiftUI

struct AppIconView: View {
    let app: AppItem
    @State private var isPressed = false

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [app.color.opacity(0.8), app.color]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                    .shadow(color: app.color.opacity(0.4), radius: 8, x: 0, y: 4)

                Image(systemName: app.icon)
                    .font(.system(size: 26))
                    .foregroundColor(.white)
            }
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.2), value: isPressed)

            Text(app.name)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
                .lineLimit(1)
        }
        .onTapGesture {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
            }
        }
    }
}