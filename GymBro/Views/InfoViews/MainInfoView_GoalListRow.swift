//
//  MainInfoView_GoalListRow.swift
//  GymBro
//
//  Created by user239615 on 5/9/23.
//

import SwiftUI

/// The progress list row in `MainInfoView`
///
/// It has a progress bar, a edit button, and a delete button
struct MainInfoView_GoalListRow: View {
    
    
    // MARK: PROPERTY
    
    @ObservedObject var goalVM = GoalViewModel.instance
    
    /// A list row represents a GoalModel
    @State var goal: GoalModel
    
    // Animation Control Units
    @Binding var pulseEffect: Bool
    @Binding var pulseAnimationIsActive: Bool
    
    // Sheet Control Variable //
    
    /// To show if the current state is `update` or `add` for goal
    @State var updateSheetActive: Bool = false
    @Binding var sheetExerciseName: String
    @Binding var sheetProgress: Int
    
    // Delete Alert Control Unit
    @State var deleteAlertActive: Bool = false
    
    
    // MARK: BODY
    
    var body: some View {
            HStack {
                
                // The left section, progress bar title and progress bar
                VStack(spacing: 5) {
                    
                    // Set the var for cleaner code
                    let progressRate = goalVM.getGoalProgress(goalModel: goal)
                    
                    HStack {
                        Text("\(self.goal.exerciseName): %\(Int(progressRate * 100))")
                        Spacer()
                        Text("\(self.goal.goalWeight) lb")
                            .font(.callout)
                            .opacity(0.5)
                    }
                    
                    PulseProgressBar(progress: progressRate, pulseEffect: self.$pulseEffect, pulseAnimationIsActive: self.$pulseAnimationIsActive)
                    
                }
                .padding(.vertical, 1)
                
                // The right section, edit button and delete button
                HStack {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            self.updateSheetActive = true
                            self.sheetExerciseName = goal.exerciseName
                            self.sheetProgress = goalVM.calculateProgress(goal: goal)
                        }
                        .sheet(isPresented: self.$updateSheetActive) {
                           MainInfoView_GoalSheet(
                                goal: goal,
                                isUpdateGoal: true,
                                pulseAnimationIsActive: self.$pulseAnimationIsActive,
                                newGoalExercise: self.$sheetExerciseName,
                                newProgress: self.$sheetProgress
                            )
                        }
                    
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .onTapGesture {
                            self.deleteAlertActive = true
                        }
                        .alert(isPresented: self.$deleteAlertActive) {
                            self.deleteAlert(goal: goal)
                        }
                }
            }
        
    }
}


// MARK: COMPONENT

extension MainInfoView_GoalListRow {
    
    /// Alert for delete goal action and delete after confirmation
    func deleteAlert(goal: GoalModel) -> Alert {
            Alert(
                title: Text("Delete Goal"),
                message: Text("Are you sure you want to delete this goal? The action cannot be undone!"),
                primaryButton: .destructive(Text("Delete")) {
                    goalVM.deleteGoal(goal: goal)
                },
                secondaryButton: .cancel()
            )
    }
}


// MARK: PREVIEW

struct MainInfoView_GoalListRow_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView()
    }
}
