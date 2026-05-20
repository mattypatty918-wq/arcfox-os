import SwiftUI

struct AppIconView: View {
    let app: AppItem
    var size: CGFloat = 60

    var body: some View {
        VStack(spacing: 5) {
            ZStack {
                RoundedRectangle(cornerRadius: size * 0.267)
                    .fill(
                        LinearGradient(
                            colors: [app.color, app.color.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)
                    .shadow(color: app.color.opacity(0.4), radius: 6, x: 0, y: 4)

                Image(systemName: app.icon)
                    .font(.system(size: size * 0.433))
                    .foregroundColor(.white)
            }

            Text(app.name)
                .font(.system(size: size * 0.133, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(width: size + 10)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
        }
    }
}

struct AppIconView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            HStack(spacing: 20) {
                AppIconView(app: AppItem(name: "Safari", icon: "safari.fill", color: .blue))
                AppIconView(app: AppItem(name: "Messages", icon: "message.fill", color: .green))
            }
        }
    }
}