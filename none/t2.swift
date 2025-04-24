//import SwiftUI
//
//struct Model: Identifiable, Codable {
//    var id: UUID = UUID()
//    var name: String
//}
//
//struct v1: View {
//    @Binding var model: Workout
//
//    var body: some View {
//        VStack {
//            //            ForEach(model.exercises.indices, id: \.self) { index in
//            //                HStack {
//            //                    Text("Item \(index + 1):") //Display index
//            //                    MyTextField(name: $model.exercises[index].name) //Pass the binding
//            //                }
//            //                Button {
//            //                    print(model.exercises[index].name)
//            //                } label: {
//            //                    Text("PRINTER")
//            //                }
//            ForEach(model.exercises) { exercise in
//                Text(exercise.name)
//                ForEach(exercise.sets.indices, id: \.self) { setIndex in
//                    HStack {
//                        Text("Set Number: \(setIndex + 1)")
//                        //                        MyTextField(name: $model.exercises[0].sets[setIndex].notes) //Pass the binding
//                        MyTextField(name: Binding(
//                            get: {
//                                if let reps = exercise.sets[setIndex].reps {
//                                    return String(reps)
//                                }
//                                return ""
//                            },
//                            set: {
//                                if let reps = Int($0) {
//                                    exercise.sets[setIndex].reps = reps
//                                } else {
//                                    print("bad")
//                                }
//                            }
//                        ))
//                    }
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//struct MyTextField: View {
//    @Binding var name: String
//
//    var body: some View {
//        TextField("Enter name", text: $name)
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .frame(width: 150) // Adjust width as needed
//    }
//}
//
//#Preview {
//    //    v1()
//    struct PreviewWrapper: View {
//        @State var workout = testingWorkout
//
//        var body: some View {
//            v1(model: $workout)
//        }
//    }
//
//    return PreviewWrapper()
//}
