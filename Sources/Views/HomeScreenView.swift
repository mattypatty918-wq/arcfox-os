import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var bootManager: BootManager

    let apps: [AppItem] = [
        AppItem(name: "Safari",     icon: "safari.fill",          color: .blue),
        AppItem(name: "Messages",   icon: "message.fill",         color: .green),
        AppItem(name: "Photos",      icon: "photo.fill",           color: .yellow),
        AppItem(name: "Camera",     icon: "camera.fill",          color: .gray),
        AppItem(name: "Mail",       icon: "envelope.fill",         color: .blue),
        AppItem(name: "Maps",       icon: "map.fill",             color: .green),
        AppItem(name: "Music",      icon: "music.note",           color: .pink),
        AppItem(name: "Settings",   icon: "gearshape.fill",       color: .gray),
        AppItem(name: "Clock",      icon: "clock.fill",           color: .orange),
        AppItem(name: "Calendar",   icon: "calendar",             color: .red),
        AppItem(name: "Notes",      icon: "note.text",            color: .yellow),
        AppItem(name: "Weather",    icon: "cloud.sun.fill",       color: .cyan),
        AppItem(name: "FaceTime",   icon: "video.fill",           color: .blue),
        AppItem(name: "Podcasts",   icon: "waveform",             color: .purple),
        AppItem(name: "App Store",  icon: "app.fill",             color: .blue),
        AppItem(name: "Wallet",     icon: "creditcard.fill",      color: .black),
    ]

    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 4)

    @State private var currentTime = Date()
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            // Wallpaper
            LinearGradient(
                colors: [Color(hex: "#1a1a2e"), Color(hex: "#16213e"), Color(hex: "#0f3460")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Status Bar
                HStack {
                    Text(currentTime, format: .dateTime.hour().minute())
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .onReceive(timer) { _ in
                            currentTime = Date()
                        }

                    Spacer()

                    HStack(spacing: 6) {
                        Image(systemName: "wifi")
                        Image(systemName: "battery.100")
                            .symbolRenderingMode(.hierarchical)
                    }
                    .font(.caption)
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)

                Spacer()

                // App Grid
                LazyVGrid(columns: columns, spacing: 28) {
                    ForEach(apps) { app in
                        AppIconView(app: app)
                    }
                }
                .padding(.horizontal, 20)

                Spacer()

                // Dock
                HStack(spacing: 28) {
                    ForEach(apps.prefix(4)) { app in
                        AppIconView(app: app, size: 52)
                    }
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 28)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .padding(.bottom, 16)

                // Bottom bar
                HStack {
                    Button(action: { bootManager.lock() }) {
                        Image(systemName: "lock.fill")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.6))
                    }

                    Spacer()

                    Button(action: { bootManager.shutdown() }) {
                        Label("Power Off", systemImage: "power")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            currentTime = Date()
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(BootManager())
    }
}