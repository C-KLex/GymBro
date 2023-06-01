//
//  Rexercise_ExerciseListRow.swift
//  GymBro
//
//  Created by 陳宜葳 on 5/23/23.
//
//  This is the view for user to check what's already in the exercise list.

import SwiftUI

struct Rexercise_ExerciseListRow: View {
    
    
    // MARK: PROPERTY
    
    @State var trainingExercise: TrainingExerciseModel
        
    /// Show the drop down set list.
    @State var showSet: Bool = false
    
    /// Show the EditSetView as a pop-up sheet
    @State var showAddSetSheet: Bool = false
    @State var showUpdateSetSheet: Bool = false
    
    @State var selectedWeight: Int = 120
    @State var selectedReps: Int = 5
    
    // MARK: BODY
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text(trainingExercise.name)
                    .foregroundColor(.black)
                Spacer()
                
                HStack {
                    self.showSet ? Image(systemName: "chevron.down") : Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    self.showSet.toggle()
                }
                    
            }
            
            if showSet {
                
                VStack(spacing: 5) {
                    
                    ForEach(trainingExercise.setList, id: \.id) { s in
                        HStack {
                            Text("\(s.weight) lb")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .frame(width: 90)
                                .background(Color.gray.cornerRadius(10).opacity(0.2))
                            
                            Spacer()
                            
                            Text("\(s.reps) reps")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .frame(width: 90)
                                .background(Color.gray.cornerRadius(10).opacity(0.2))
                        }
                        .padding(.horizontal)
                        .onTapGesture {
                            self.updateWeightReps(weight: s.weight, reps: s.reps)
                            self.showUpdateSetSheet = true
                        }
                        .sheet(isPresented: self.$showUpdateSetSheet) {
                            RExercise_SetRow_UpdateSetSheet(selectedWeight: self.$selectedWeight, selectedRep: self.$selectedReps, trainingExercise: trainingExercise, trainingSet: s)
                        }
                        
                    }
                    
                    HStack {
                        Text("+ Add Set")
                    }
                    .onTapGesture {
                        self.showAddSetSheet = true
                    }
                    .sheet(isPresented: $showAddSetSheet) {
                        RExercise_SetRow_AddSetSheet(selectedWeight: self.$selectedWeight, selectedRep: self.$selectedReps, trainingExercise: trainingExercise)
                    }
                }
            }   // End if showSet
        }   // End of VStack
            
    }
}

extension Rexercise_ExerciseListRow {
    func updateWeightReps(weight: Int, reps: Int) -> (){
        self.selectedWeight = weight
        self.selectedReps = reps
    }
}

// MARK: PREVIEW

struct ShowSetsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineExerciseView()
        }
    }
}
