import SwiftUI

struct AppItem: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
}

struct HomeScreenView: View {
    @EnvironmentObject var bootManager: BootManager
    @State private var showDock = true
    @State private var selectedApp: AppItem?
    @State private var showApp = false

    let apps: [AppItem] = [
        AppItem(name: "Safari", icon: "globe", color: Color(hex: "007AFF")),
        AppItem(name: "Photos", icon: "photo", color: Color(hex: "FF9500")),
        AppItem(name: "Camera", icon: "camera", color: Color(hex: "8E8E93")),
        AppItem(name: "Music", icon: "music.note", color: Color(hex: "FA2D48")),
        AppItem(name: "Mail", icon: "envelope", color: Color(hex: "007AFF")),
        AppItem(name: "Calendar", icon: "calendar", color: Color(hex: "FF3B30")),
        AppItem(name: "Notes", icon: "note.text", color: Color(hex: "FFCC00")),
        AppItem(name: "Maps", icon: "map", color: Color(hex: "34C759")),
        AppItem(name: "Settings", icon: "gear", color: Color(hex: "8E8E93")),
        AppItem(name: "Clock", icon: "clock", color: Color(hex: "000000")),
        AppItem(name: "Weather", icon: "cloud.sun", color: Color(hex: "5AC8FA")),
        AppItem(name: "Files", icon: "folder", color: Color(hex: "007AFF")),
        AppItem(name: "App Store", icon: "bag", color: Color(hex: "5AC8FA")),
        AppItem(name: "FaceTime", icon: "video", color: Color(hex: "32D74B")),
        AppItem(name: "Messages", icon: "message", color: Color(hex: "34C759"))
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "1A1A2E"),
                    Color(hex: "0F0F1A")
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Status bar
                HStack {
                    Text("12:30")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 6) {
                        Image(systemName: "wifi")
                        Image(systemName: "battery.75")
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)

                Spacer()

                // App grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 30) {
                    ForEach(apps) { app in
                        AppIconView(app: app)
                            .onTapGesture {
                                selectedApp = app
                                showApp = true
                            }
                    }
                }
                .padding(.horizontal, 20)

                Spacer()

                // Page indicator
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
                .padding(.bottom, 15)

                // Dock
                if showDock {
                    HStack(spacing: 25) {
                        ForEach(["safari", "messages", "photos", "camera", "settings"].indices, id: \.self) { index in
                            Image(systemName: ["globe", "message", "photo", "camera", "gear"][index])
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.15))
                                )
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.1))
                    )
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                Spacer()
                    .frame(height: 30)
            }
        }
        .onAppear {
            showDock = true
        }
    }
}