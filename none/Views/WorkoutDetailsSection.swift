//
//  WorkoutDetailsSection.swift
//  none
//
//  Created by Max Vaughan on 17.03.2025.
//

import SwiftUI

struct WorkoutDetailsSection: View {
    @Binding var templateName: String
    @Binding var duration: String
    
    var body: some View {
        Form {
            Section(header: Text("Workout Details")) {
                TextField("Workout Name (Optional)", text: $templateName)
                TextField("Duration (minutes)", text: $duration)
                    .keyboardType(.numberPad)
            }
        }
    }
}
