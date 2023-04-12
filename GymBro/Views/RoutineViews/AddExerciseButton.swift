//
//  AddExerciseButton.swift
//  GymBro
//
//  Created by Claire on 4/11/23.
//
//  This view creates a pop-up sheet including a wheel picker for user to
//  choose which exercise to add to the routine list of day.
//  By clicking "New" button, the user can add an new exercise that does not
//  exist to the wheel picker.

import SwiftUI

struct AddExerciseButton: View {
    
    // MARK: PROPERTY
    
    @Environment(\.presentationMode) var presentationMode
    @State var selection: String = "Bar Bell Chest"
    @State var exercise: [String] = ["Bar Bell Chest", "Bar Bell Up", "Cable Mid", "Cable Low"]
    @State var showSheet: Bool = false
    
    // MARK: BODY
    
    var body: some View {
        
        VStack {
            
            // Show all existed exercises
            Picker(
                "+ Add Exercise",
                selection: $selection,
                content: {
                    ForEach(exercise, id: \.self, content: {
                        Text($0)
                    })
                })
            .pickerStyle(.wheel)
                
            HStack {
                // Add a new exercise to the routine list
                Button(action: {
                    showSheet.toggle()
                }, label: {
                    Text("New")
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 60)
                        .background(
                            Color.gray
                                .opacity(0.4)
                                .cornerRadius(8))
                })
                .sheet(isPresented: $showSheet, content: {
                    AddNewExercise(selection: $selection)
                })
                .padding(.horizontal, 5)
                
                // Add an existed exercise to the routine list
                Button(action: {
                    //exerciseViewModel.addExercise(title: selection)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 60)
                        .background(
                            Color.gray
                                .opacity(0.4)
                                .cornerRadius(8))
                })
                .padding(.horizontal, 5)
            }   // End of HStack

        }   // End of VStack
    }
}

struct AddExerciseButton_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseButton()
    }
}
