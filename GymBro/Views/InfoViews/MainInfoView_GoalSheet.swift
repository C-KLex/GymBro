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
    
    /// init parameter
    ///
    /// To control the overall animation boolean status
    @Binding var pulseAnimationIsActive: Bool 

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
            DismissButtonView()
            self.exerciseWheel()
            self.progressWheel()
            Spacer()
            
            // add goal button
            /*
             The process in `.onTapGesture` is important, so it needs to be shown.
             */
            self.addGoalButton()
                .onTapGesture {
                    self.checkEmptyExerciseWheel()
                    self.checkEmptyProgressWheel()
                    goalViewModel.addGoal(exerciseName: newGoalExercise, progressWeight: newProgress)
                    self.resetAnimation()
                    self.presentationMode.wrappedValue.dismiss()
                }

            Spacer()
        }
    }
}


// MARK: COMPONENT

extension MainInfoView_GoalSheet {
    
    func exerciseWheel() -> some View {
        HStack {
            Text("Pick A Exercise")
                .font(.headline)
            
            Picker("progress", selection: self.$newGoalExercise) {
                ForEach(goalViewModel.exercisePool, id: \.exerciseName) { exerciseTopWeightModel in
                    Text(exerciseTopWeightModel.exerciseName)
                }
            }
            .pickerStyle(.wheel)
        }
        .padding(.horizontal)
    }
    
    func progressWheel() -> some View {
        HStack(alignment: .center) {
            Text("New Progress")
                .font(.headline)
            
            Picker("progress", selection: self.$newProgress) {
                ForEach(self.newProgressArray, id: \.self) { number in
                    Text("+ \(number)")
                }
            }
            .pickerStyle(.wheel)
        }
        .padding(.horizontal)
    }
    
    func addGoalButton() -> some View {
        VStack {
            Text("Add Goal")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black)
        .cornerRadius(20)
    }
    
    /// Reset all the progressBar animation in `MainInfoView`
    ///
    /// Without reseting, the progressBar animation would have multiple pulsing at the same time. Therefore, all the progresBar wouldn't have the same pulsing frequecy.
    ///
    /// - Warning: Each progressBar may have slighly different pulsing starting time. (I don't want to fix this at this stage)
    func resetAnimation() -> () {
        self.pulseAnimationIsActive = false
    }

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
