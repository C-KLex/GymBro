//
//  MainInfoView_GoalSheet.swift
//  GymBro
//
//  Created by user239615 on 5/4/23.
//

import SwiftUI

/// Add Goal sheet 
/// 
/// User can pick a specific exercise and a desired goal. Then add it as a new goal.
struct MainInfoView_GoalSheet: View {


    // MARK: PROPERTY 

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var goalViewModel = GoalViewModel.instance

    /// variable for exercise picking wheel  
    @State var newGoalExercise: String = ""

    /// variable for progress picking wheel 
    @State var newProgress: Int = -1

    /// content for the progress picking wheel 
    private let newProgressArray = Array(stride(from: 5, to: 100, by: 5))


    // MARK: BODY 

    var body: some View {
        VStack {
            
            // Dismiss button
            DismissButtonView()
            
            /// Exercise Picking Wheel 
            HStack {
                Text("Pick A Exercise")
                    .font(.headline)
                
                Picker("progress", selection: $newGoalExercise) {
                    ForEach(goalViewModel.exercisePool, id: \.exerciseName) { exerciseTopWeightModel in
                        Text(exerciseTopWeightModel.exerciseName)
                    }
                }
                .pickerStyle(.wheel)
            }
            .padding(.horizontal)
            
            /// Progress Picking Wheel
            HStack(alignment: .center) {
                Text("New Progress")
                    .font(.headline)
                
                Picker("progress", selection: $newProgress) {
                    ForEach(newProgressArray, id: \.self) { number in
                        Text("+ \(number)")
                    }
                }
                .pickerStyle(.wheel)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Add Goal Button
            VStack {
                Text("Add Goal")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.black)
            .cornerRadius(20)
            .onTapGesture {
                checkEmptyExerciseWheel()
                checkEmptyProgressWheel()
                goalViewModel.addGoal(exerciseName: newGoalExercise, progressWeight: newProgress)
                presentationMode.wrappedValue.dismiss()
            }
            
            Spacer()
        }
    }
}


/// MARK: COMPONENT

extension MainInfoView_GoalSheet {

    /// Set a default exercise if needed 
    /// 
    /// If the wheel is not touched, SwiftUI would not update the binding variable. 
    func checkEmptyExerciseWheel() -> () {
        if self.newGoalExercise == "" {
            self.newGoalExercise = goalViewModel.exercisePool[0].exerciseName
        }
    }
    
    /// Set a default progress if needed
    /// 
    /// If the wheel is not touched, SwiftUI would not update the binding variable.
    func checkEmptyProgressWheel() {
        if self.newProgress == -1 {
            self.newProgress = self.newProgressArray[0]
        }
    } 
}


// MARK: PREVIEW

struct MainInfoView_GoalSheet_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView(goalSheetActive: true)
    }
}
