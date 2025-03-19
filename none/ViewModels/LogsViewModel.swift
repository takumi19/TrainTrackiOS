//
//  LogsViewModel.swift
//  none
//
//  Created by Max Vaughan on 17.03.2025.
//

import SwiftUI

class LogsViewModel: ObservableObject {
    @Published var workouts: [Workout] = []
    
    func addWorkout(_ workout: Workout) {
        workouts.append(workout)
        workouts.sort { $0.date > $1.date } // Sort by latest date
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return "\(minutes) min \(seconds) sec"
    }
}
