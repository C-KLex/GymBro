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
    
  
    @Binding var pulseAnimationIsActive: Bool 

    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var goalVM = GoalViewModel.instance


    @Binding var newGoalExercise: String

    
    @Binding var newProgress: Int 

     
    private let newProgressArray = Array(stride(from: 5, to: 100, by: 5))
    
    @State var isUpdateGoal: Bool
    
    @State var showGoalExistAlert: Bool = false
    
    @State var goal: GoalModel?

    // MARK: BODY 

    var body: some View {
        VStack {
            DismissButtonView()
            Spacer()
            self.exercisePickerSection(isUpdateGoal: self.isUpdateGoal)
            self.progressWheel()
            
            Spacer()
            
            self.finalButton(isUpdateGoal: self.isUpdateGoal)
            
           

            Spacer()
        }
    }
}


// MARK: COMPONENT

extension MainInfoView_GoalSheet {
    
    @ViewBuilder
    func exercisePickerSection(isUpdateGoal: Bool) -> some View {
        if isUpdateGoal {
            HStack {
                Text("Exercise: ")
                    .font(.title)
                    .fontWeight(.semibold)
                Text(self.newGoalExercise)
                    .font(.title)
            }
        } else {
            self.exerciseWheel()
        }
        
        
    }
    
    @ViewBuilder
    func finalButton(isUpdateGoal: Bool) -> some View{
        if isUpdateGoal {
            self.updateGoalButton()
        } else {
            self.addGoalButton()
        }
    }
    
    
    func updateGoalButton() -> some View {
        VStack {
            Text("Update Goal")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(20)
        .onTapGesture {
            if let goal = goal {
                goalVM.updateGoal(goal: goal, newProgress: self.newProgress)
                self.resetAnimation()
                self.presentationMode.wrappedValue.dismiss()
                
            }
        }
    }
    
    func exerciseWheel() -> some View {
        HStack {
            Text("Pick A Exercise")
                .font(.headline)
            
            Picker("progress", selection: self.$newGoalExercise) {
                ForEach(goalVM.exercisePool, id: \.exerciseName) { exerciseTopWeightModel in
                    Text(exerciseTopWeightModel.exerciseName)
                        .tag(exerciseTopWeightModel.exerciseName)
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
                        .tag(number)
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
        .onTapGesture {
            self.checkEmptyExerciseWheel()
            self.checkEmptyProgressWheel()
            self.addGoal()
        }
        .alert(isPresented: self.$showGoalExistAlert) {
            self.goalExistAlert(exerciseName: self.newGoalExercise)
        }
    }
    
    
    func addGoal() {
        guard !goalVM.isGoalExist(exerciseName: self.newGoalExercise) else {
            self.showGoalExistAlert = true
            return
        }
        goalVM.addGoal(exerciseName: newGoalExercise, progressWeight: newProgress)
        self.resetAnimation()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func goalExistAlert(exerciseName: String) -> Alert {
        Alert(
            title: Text("Error!!!").foregroundColor(.red),
            message: Text("\(exerciseName) has been added already!"),
            dismissButton: .default(Text("OK"))
        )
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
            self.newGoalExercise = goalVM.exercisePool[0].exerciseName
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
