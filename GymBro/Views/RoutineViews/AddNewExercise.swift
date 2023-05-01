//
//  AddNewExercise.swift
//  GymBro
//
//  Created by Claire on 4/12/23.
//
//  This view is a pop-up sheet to add any new exercise to the existed
//  exercise list.

import SwiftUI

struct AddNewExercise: View {
    
    
    // MARK: PROPERTY
    
    @State var textFieldText: String = ""
    
    /// Direct back to RoutineExerciseView.
    @State var showRoutineView: Bool = false
    
    /// The new added exercise that user type
    @Binding var selection: String
    @Environment(\.presentationMode) var presentationMode
    
    
    // MARK: BODY
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                /// Textfield to type your new exercise
                TextField("Add your new exercise here!!", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                /// Press button to save new exercise you type
                Button(action: {
                    saveButtonPressed()
                    showRoutineView.toggle()
                }, label: {
                        Text("save".uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                })

                Spacer()
            }   // End of VStack
            .navigationTitle("Add New Exercise 📝")
        }   // End of NavigationView
        .padding(10)

    }
    
    
    // MARK: METHOD
    
    func saveButtonPressed() {
        //exerciseViewModel.addExercise(title: textFieldText)
        selection = textFieldText
        presentationMode.wrappedValue.dismiss()
    }
}


// MARK: PREVIEW

struct AddNewExercise_Previews: PreviewProvider {
    
    @State static var selection = "Barbell Chest"
    
    static var previews: some View {
        AddNewExercise(selection: $selection)
    }
}
