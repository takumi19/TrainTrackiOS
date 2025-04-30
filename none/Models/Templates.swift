//
//  Templates.swift
//  none
//
//  Created by Max Vaughan on 25.04.2025.
//

import Foundation

struct ProgramTemplate : Encodable, Identifiable {
    var id: Int64
    var authorId: Int64
    var authorName: String
    var name: String
    var notes: String
    var weeks: [WeekTemplate]
}

struct WeekTemplate : Encodable, Identifiable {
    var id: Int64
    var notes: String
    var workouts: [Workout]
}

let programTemplates: [ProgramTemplate] = [
    // Jim Wendler's 5/3/1
    ProgramTemplate(
        id: 1,
        authorId: 101,
        authorName: "Jim Wendler",
        name: "5/3/1",
        notes: "A strength program focusing on squat, bench, deadlift, and overhead press. Uses 90% of 1RM as training max. Cycle: 3 weeks of 5/3/1 reps, 1 deload week. Progression: Add 5-10 lbs to training max per cycle.",
        weeks: [
            WeekTemplate(
                id: 1,
                notes: "Week 1: 5/5/5+ (65%, 75%, 85% of training max)",
                workouts: [
                    Workout(
                        id: 101,
                        templateName: "5/3/1",
                        weekNumber: 1,
                        workoutNumber: 1,
                        name: "Squat Day",
                        exercises: [
                            Exercise(
                                id: 1,
                                name: "Squat",
                                movementType: .Dynamic,
                                resistanceType: .weighted,
                                bestSet: "5+ @ 85% TM",
                                sets: [
                                    SetDetail(id: 1001, suggestedReps: 5, weight: 0.65 * 0.9 * 100, notes: "65% TM"),
                                    SetDetail(id: 1002, suggestedReps: 5, weight: 0.75 * 0.9 * 100, notes: "75% TM"),
                                    SetDetail(id: 1003, suggestedRepsMin: 5, weight: 0.85 * 0.9 * 100, notes: "85% TM, AMRAP")
                                ]
                            )
                        ]
                    ),
                    // Add similar workouts for Bench, Deadlift, Overhead Press
                ]
            ),
            WeekTemplate(
                id: 2,
                notes: "Week 2: 3/3/3+ (70%, 80%, 90% of training max)",
                workouts: [] // Similar structure, adjust percentages
            ),
            WeekTemplate(
                id: 3,
                notes: "Week 3: 5/3/1+ (75%, 85%, 95% of training max)",
                workouts: [] // Similar structure, adjust percentages
            ),
            WeekTemplate(
                id: 4,
                notes: "Week 4: Deload (40%, 50%, 60% of training max)",
                workouts: [] // Lighter sets
            )
        ]
    ),

    // GZCLP
    ProgramTemplate(
        id: 2,
        authorId: 102,
        authorName: "Cody Lefever",
        name: "GZCLP",
        notes: "Linear progression for novices. Tiered lifts: T1 (main, 85-100% 1RM), T2 (secondary, 65-85%), T3 (accessory, high reps). Progression: Add 5-10 lbs when AMRAP hits target reps, reset if fail 3x.",
        weeks: [
            WeekTemplate(
                id: 5,
                notes: "4 workouts per week, rotating T1/T2 lifts",
                workouts: [
                    Workout(
                        id: 201,
                        templateName: "GZCLP",
                        weekNumber: 1,
                        workoutNumber: 1,
                        name: "Squat Day",
                        exercises: [
                            Exercise(
                                id: 2,
                                name: "Squat (T1)",
                                movementType: .Dynamic,
                                resistanceType: .weighted,
                                bestSet: "5x3 @ 85% 1RM",
                                sets: [
                                    SetDetail(id: 2001, suggestedReps: 3, weight: 0.85 * 100, notes: "T1, 5 sets, AMRAP last set"),
                                    SetDetail(id: 2002, suggestedReps: 3, weight: 0.85 * 100),
                                    SetDetail(id: 2003, suggestedReps: 3, weight: 0.85 * 100),
                                    SetDetail(id: 2004, suggestedReps: 3, weight: 0.85 * 100),
                                    SetDetail(id: 2005, suggestedRepsMin: 3, weight: 0.85 * 100, notes: "AMRAP")
                                ]
                            ),
                            Exercise(
                                id: 3,
                                name: "Bench Press (T2)",
                                movementType: .Dynamic,
                                resistanceType: .weighted,
                                bestSet: "3x10 @ 65% 1RM",
                                sets: [
                                    SetDetail(id: 2006, suggestedReps: 10, weight: 0.65 * 100, notes: "T2, 3 sets")
                                ]
                            )
                        ]
                    ),
                    // Add workouts for Bench (T1), Deadlift (T1), Overhead Press (T1)
                ]
            )
        ]
    ),

    // Basic Push-Pull
    ProgramTemplate(
        id: 3,
        authorId: 103,
        authorName: "Generic",
        name: "Basic Push-Pull",
        notes: "Simple 2x/week program for beginners. Push (bench, overhead press) and Pull (deadlift, rows). Linear progression: Add 5 lbs weekly if sets completed.",
        weeks: [
            WeekTemplate(
                id: 6,
                notes: "2 workouts per week",
                workouts: [
                    Workout(
                        id: 301,
                        templateName: "Basic Push-Pull",
                        weekNumber: 1,
                        workoutNumber: 1,
                        name: "Push Day",
                        exercises: [
                            Exercise(
                                id: 4,
                                name: "Bench Press",
                                movementType: .Dynamic,
                                resistanceType: .weighted,
                                bestSet: "3x8 @ moderate weight",
                                sets: [
                                    SetDetail(id: 3001, suggestedReps: 8, weight: 50.0, notes: "3 sets"),
                                    SetDetail(id: 3002, suggestedReps: 8, weight: 50.0),
                                    SetDetail(id: 3003, suggestedReps: 8, weight: 50.0)
                                ]
                            ),
                            Exercise(
                                id: 5,
                                name: "Overhead Press",
                                movementType: .Dynamic,
                                resistanceType: .weighted,
                                bestSet: "3x8 @ moderate weight",
                                sets: [
                                    SetDetail(id: 3004, suggestedReps: 8, weight: 30.0, notes: "3 sets")
                                ]
                            )
                        ]
                    ),
                    Workout(
                        id: 302,
                        templateName: "Basic Push-Pull",
                        weekNumber: 1,
                        workoutNumber: 2,
                        name: "Pull Day",
                        exercises: [
                            Exercise(
                                id: 6,
                                name: "Deadlift",
                                movementType: .Dynamic,
                                resistanceType: .weighted,
                                bestSet: "3x5 @ moderate weight",
                                sets: [
                                    SetDetail(id: 3005, suggestedReps: 5, weight: 80.0, notes: "3 sets")
                                ]
                            ),
                            Exercise(
                                id: 7,
                                name: "Barbell Row",
                                movementType: .Dynamic,
                                resistanceType: .weighted,
                                bestSet: "3x8 @ moderate weight",
                                sets: [
                                    SetDetail(id: 3006, suggestedReps: 8, weight: 40.0, notes: "3 sets")
                                ]
                            )
                        ]
                    )
                ]
            )
        ]
    )
]
