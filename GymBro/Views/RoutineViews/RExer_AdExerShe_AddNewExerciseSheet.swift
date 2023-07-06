//
//  RExer_AdExerShe_AddNewExerciseSheet.swift
//  GymBro
//
//  Created by Claire on 4/12/23.
//
//  This view is a pop-up sheet to add any new exercise to the existed
//  exercise list.

import SwiftUI

struct RExer_AdExerShe_AddNewExerciseSheet: View {
    
    
    // MARK: PROPERTY
    
    @ObservedObject var rExerciseVM = RoutineExerciseVM.instance
    @Environment(\.presentationMode) var presentationMode
    
    /// Binding variable for textField
    @State var textFieldText: String = ""

    
    // MARK: BODY
    
    var body: some View {
            VStack {
                
                DismissButtonView()

                HStack {
                    Text("Add New Exercise 📝")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                TextField("Add your new exercise here!!", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                HStack {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .onTapGesture {
                    self.addNewExerciseOrNot(text: self.textFieldText)
                    presentationMode.wrappedValue.dismiss()
                }
               
                Spacer()
            }
            .padding(.horizontal)
    }
}


// MARK: COMPONENT

extension RExer_AdExerShe_AddNewExerciseSheet{
    
    func addNewExerciseOrNot(text: String) -> () {
        if textFieldText != "" {
            rExerciseVM.addNewExerciseToPool(exerciseName: text)
        }
    }
}

// MARK: PREVIEW

struct AddNewExercise_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RExercise_AddExerciseSheet(isAddNewExerActive: true)
        }
    }
}
