import SwiftUI

struct LoadingDotsView: View {
    @State private var animating = false

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { index in
            Circle()
                .frame(width: 6, height: 6)
                .offset(y: animating ? -4 : 0)
                .animation(
                    .easeInOut(duration: 0.4)
                    .repeatForever()
                    .delay((Double(index) * 0.15)),
                    value:animating
                )
            }
        }
        .onAppear { animating = true }
    }
}