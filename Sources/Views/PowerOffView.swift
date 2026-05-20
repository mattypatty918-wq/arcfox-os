import SwiftUI

struct PowerOffView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "power.circle.fill")
                    .font(.system(size: 90))
                    .foregroundColor(.white.opacity(0.15))

                Text("Device is Off")
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundColor(.white.opacity(0.25))

                Spacer()

                Text("Press and hold power button to turn on")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.15))
                    .padding(.bottom, 60)
            }
        }
    }
}

struct PowerOffView_Previews: PreviewProvider {
    static var previews: some View {
        PowerOffView()
    }
}