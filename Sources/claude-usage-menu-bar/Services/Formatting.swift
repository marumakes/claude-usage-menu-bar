import Foundation

func formatResetDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d 'at' h:mm a"
    return formatter.string(from: date)
}