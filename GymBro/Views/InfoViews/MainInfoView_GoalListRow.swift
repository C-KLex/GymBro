//
//  MainInfoView_GoalListRow.swift
//  GymBro
//
//  Created by user239615 on 5/9/23.
//

import SwiftUI

struct MainInfoView_GoalListRow: View {
    
    @ObservedObject var goalVM = GoalViewModel.instance
    @State var goal: GoalModel
    
    @Binding var pulseEffect: Bool
    @Binding var pulseAnimationIsActive: Bool
    
    @State var updateSheetActive: Bool = false
    @Binding var sheetExerciseName: String
    @Binding var sheetProgress: Int
    
    @State var deleteAlertActive: Bool = false
    
    
    
    
    
    var body: some View {
        
        VStack {
            
            let progressRate = goalVM.getGoalProgress(goalModel: goal)
            
            HStack {
                
                VStack(spacing: 5) {
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
                                pulseAnimationIsActive: self.$pulseAnimationIsActive,
                                newGoalExercise: self.$sheetExerciseName,
                                newProgress: self.$sheetProgress,
                                isUpdateGoal: true,
                                goal: goal
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
}

extension MainInfoView_GoalListRow {
    
    func deleteAlert(goal: GoalModel) -> Alert{
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

struct MainInfoView_GoalListRow_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView()
    }
}
