//
//  RoutineView.swift
//  GymBro
//
//  Created by user236772 on 4/3/23.
//
//  It will show the name of routine at the left top. There will also be a list of exercise below that shows all the exercise should be done today. It will need a button to add new exercises. In addition, we can click any exercise block and see a drop down menu shows the weight and reps.


import SwiftUI

struct RoutineExerciseView: View {
    
    
    // MARK: PROPERTY
    
    /// Routine day shown as title.
    @State var routineDay: String = "Chest Day"
    
    /// Exercises list in today's routine.
    @State var exercises: [String] = ["Bar Bell Chest", "Bar Bell Up", "Cable Mid", "Cable Low"]
    
    /// Show the exercise wheel picker if "+ Add Exercise" button is pressed.
    @State var showSheet: Bool = false
    
    
    // MARK: BODY
    
    var body: some View {
        
        NavigationView {
            /// If there is no added exercise in today's routine,
            /// show "NoExerciseView". (Only "+ Add Exercise" in the view)
            /// (The following code should be added when the view model is built.)
//            if listViewModel.items.isEmpty {
//                NoExerciseView()
//                    .transition(AnyTransition.opacity.animation(.easeIn))
//            } else {
                /// if there is an exercise added, the view will show an "+ Add Exercise" button
                /// and the list of exercises
                VStack {
                    List {
                        Button("+ Add Exercise", action: {
                            showSheet.toggle()
                        })
                        .sheet(isPresented: $showSheet, content: {
                            AddExerciseButton()
                        })
                        
                        /// The list of added exercises
                        ForEach(exercises, id: \.self) { exercise in
                            EditSetView(exercise: exercise)
                        }   // End of ForEach
                        
                    }   // End of List
                    .navigationTitle(routineDay)
                    .navigationBarItems(
                        leading: EditButton(),
                        trailing:
                            NavigationLink("Finish", destination: MainView()))  // Back to Main view
                    
                }   // End of VStack
//            }   // End of if, else
        }   // End of NavigationView
    }
}


// MARK: PREVIEW

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineExerciseView()
    }
}
