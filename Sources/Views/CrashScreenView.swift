import SwiftUI

struct CrashScreenView: View {
    @EnvironmentObject var bootManager: BootManager

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 72))
                    .foregroundColor(.red)
                    .symbolEffect(.pulse)

                Text("System Crashed")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("ArcFox OS encountered an error")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()

                Button(action: { bootManager.reboot() }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Reboot System")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(Color.red.opacity(0.8))
                    .clipShape(Capsule())
                }
                .padding(.bottom, 80)
            }
        }
    }
}

struct CrashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CrashScreenView()
            .environmentObject(BootManager())
    }
}