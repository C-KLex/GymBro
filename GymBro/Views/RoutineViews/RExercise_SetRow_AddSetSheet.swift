//
//  RExercise_SetRow_AddSetSheet.swift
//  GymBro
//
//  Created by Claire on 4/27/23.
//
//  This view is a pop-up sheet. Two pickers for selecting weights and reps.

import SwiftUI

/// Add new set for the exercise
struct RExercise_SetRow_AddSetSheet: View {
    
    
    // MARK: PROPERTY
    
    @ObservedObject var rExerciseVM = RoutineExerciseViewModel.instance
    
    // Binding Variable for The Pickers
    @Binding var selectedWeight: Int
    @Binding var selectedRep: Int
    
    /// The Exercise which the set is added to
    @State var trainingExercise: TrainingExerciseModel
    
    @Environment(\.presentationMode) var presentationMode

    
    // MARK: BODY
    
    var body: some View {
        VStack {
            DismissButtonView()
            
            HStack {
                Picker("Select Weight", selection: $selectedWeight) {
                    ForEach(10...200, id: \.self) { weight in
                        if weight % 5 == 0 {
                            Text("\(weight) lb").tag("\(weight)")
                        }
                    }
                }
                .pickerStyle(.wheel)
                
                Picker("Select Rep", selection: $selectedRep) {
                    ForEach(1...15, id: \.self) { rep in
                        Text("\(rep)").tag("\(rep)")
                    }
                }
                .pickerStyle(.wheel)
            }
            .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            
            HStack {
                Text("+ Add Set")
                    .padding()
                    .padding(.horizontal, 5)
                    .background(Color.gray.cornerRadius(10).opacity(0.2))
            }
            .onTapGesture {
                rExerciseVM.addNewSetToExercise(weight: self.selectedWeight, reps: self.selectedRep, exercise: self.trainingExercise)
                presentationMode.wrappedValue.dismiss()
            }
            
            Spacer()
        }
    }
}


// MARK: PREVIEW

struct EditSetView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineExerciseView()
    }
}
