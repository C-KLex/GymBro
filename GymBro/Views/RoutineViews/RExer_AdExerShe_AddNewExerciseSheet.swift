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
    
    @ObservedObject var rExerciseVM = RoutineExerciseViewModel.instance
    
    @State var textFieldText: String = ""
    
    /// The new added exercise that user type
    @Binding var selection: String
    @Environment(\.presentationMode) var presentationMode
    
    
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
                    if textFieldText != "" {
                        print("Inside")
                        rExerciseVM.addNewExerciseToPool(exerciseName: textFieldText)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
               
                Spacer()
                
            }
            .padding(.horizontal)
    }
}


// MARK: COMPONENT

extension RExer_AdExerShe_AddNewExerciseSheet{
    func saveButtonPressed() {
        //exerciseViewModel.addExercise(title: textFieldText)
        selection = textFieldText
        presentationMode.wrappedValue.dismiss()
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
