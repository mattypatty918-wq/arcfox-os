import SwiftUI

struct AppItem: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color

    static func == (lhs: AppItem, rhs: AppItem) -> Bool {
        lhs.id == rhs.id
    }
}