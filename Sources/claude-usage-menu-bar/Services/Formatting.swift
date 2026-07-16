import Foundation

func formatResetDate(_ date: Date) -> String {
    date.formatted(Date.FormatStyle().month(.abbreviated).day(.twoDigits).hour(.defaultDigits(amPM: .abbreviated)).minute(.twoDigits))
}