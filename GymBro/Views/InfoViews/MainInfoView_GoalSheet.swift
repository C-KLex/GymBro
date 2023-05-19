//
//  MainInfoView_GoalSheet.swift
//  GymBro
//
//  Created by user239615 on 5/4/23.
//

import SwiftUI

/// Goal Edit Sheet
///
/// Access the goalModel data in two state, `update` and `add`.
/// In different state, the sheet will have different layout, most of both's layout are similart, so I don't seperate two states into two sheet for avoiding code duplication.
struct MainInfoView_GoalSheet: View {


    // MARK: PROPERTY
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var goalVM = GoalViewModel.instance
    
    @State var goal: GoalModel?
    @State var isUpdateGoal: Bool
    @State var showGoalExistAlert: Bool = false
    
    @Binding var pulseAnimationIsActive: Bool
    @Binding var newGoalExercise: String
    @Binding var newProgress: Int

    /// Data for Progress Picker
    private let newProgressArray = Array(stride(from: 5, to: 100, by: 5))
    
    
    

    // MARK: BODY 

    var body: some View {
        VStack {
            DismissButtonView()
            
            Spacer()
            
            self.exercisePickerDecide(isUpdateGoal: self.isUpdateGoal)
            self.progressWheel()
            
            Spacer()
            
            self.finalButtonDecide(isUpdateGoal: self.isUpdateGoal)
        
            Spacer()
        }
    }
}


// MARK: COMPONENT

extension MainInfoView_GoalSheet {
    
    func goalExistAlert(exerciseName: String) -> Alert {
        Alert(
            title: Text("Error!!!").foregroundColor(.red),
            message: Text("\(exerciseName) has been added already!"),
            dismissButton: .default(Text("OK"))
        )
    }

    @ViewBuilder
    /// Logic for choosing which picker to present between `update` and `add` state
    /// - Parameter isUpdateGoal: to see it's now `update` or `add`
    /// - Returns: In `update`, user can't change the exercise for the existing goal. In `add`, user can deside which exercise to add as a new goal
    func exercisePickerDecide(isUpdateGoal: Bool) -> some View {
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
    /// Logic for choosing which button to present between `update` and `add` state
    /// - Parameter isUpdateGoal: it's now `update` or `add`
    /// - Returns: `updateGoalButton` or `addGoalButton`
    func finalButtonDecide(isUpdateGoal: Bool) -> some View{
        if isUpdateGoal {
            self.updateGoalButton()
        } else {
            self.addGoalButton()
        }
    }
    
    /// Perform the add goal function
    ///
    ///
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
            
            // set default value and check goal's existence before adding goal
            self.checkEmptyExerciseWheel()
            self.checkEmptyProgressWheel()
            guard !goalVM.isGoalExist(exerciseName: self.newGoalExercise) else {
                self.showGoalExistAlert = true
                return
            }
            
            // if all set, then add goal
            self.addGoal()
        }
        .alert(isPresented: self.$showGoalExistAlert) {
            self.goalExistAlert(exerciseName: self.newGoalExercise)
        }
    }
    
    /// addGoal precedure
    ///
    /// add goal to the data base, then reset the progress bar animation due to the creation of new progress bar from new goal
    func addGoal() {
        goalVM.addGoal(exerciseName: newGoalExercise, progressWeight: newProgress)
        self.resetAnimation()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    /// Update the exercise goal progress for the existing goal
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
    
    /// exercise picker in the sheet
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
    
    /// progress picker in the sheet
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
