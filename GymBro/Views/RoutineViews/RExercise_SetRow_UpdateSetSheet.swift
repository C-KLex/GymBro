//
//  RExercise_SetRow_UpdateSetSheet.swift
//  GymBro
//
//  Created by user239615 on 6/3/23.
//

import SwiftUI

/// Update a set of a exercise
struct RExercise_SetRow_UpdateSetSheet: View {

    // MARK: PROPERTY
    
    // Binding Variable for Picker
    @Binding var selectedWeight: Int
    @Binding var selectedRep: Int
    
    /// Updated Exercise Model
    @State var trainingExercise: TrainingExerciseModel
    
    /// Updated Set Model
    @State var trainingSet: TrainingSetModel
    
    @ObservedObject var rExerciseVM = RoutineExerciseViewModel.instance
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
                Text("Update")
                    .padding()
                    .padding(.horizontal, 5)
                    .background(Color.gray.cornerRadius(10).opacity(0.2))
            }
            .onTapGesture {
                rExerciseVM.updateSet(weight: self.selectedWeight, reps: self.selectedRep, exercise: self.trainingExercise, trainingSet: self.trainingSet)
                presentationMode.wrappedValue.dismiss()
            }
            
            Spacer()
        }
    }
}

struct RExercise_SetRow_UpdateSetSheet_Previews: PreviewProvider {
    static var previews: some View {
        RoutineExerciseView()
    }
}
