//
//  RExercise_AddExerciseSheet.swift
//  GymBro
//
//  Created by Claire on 4/11/23.
//
//  This view creates a pop-up sheet including a wheel picker for user to
//  choose which exercise to add to the routine list of day.
//  By clicking "New" button, the user can add an new exercise that does not
//  exist to the wheel picker.

import SwiftUI

struct RExercise_AddExerciseSheet: View {
    
    
    // MARK: PROPERTY
    @ObservedObject var rExerciseVM = RoutineExerciseViewModel.instance
    
    @Environment(\.presentationMode) var presentationMode
    @State var selection: String = "Bar Bell Chest"
    @State var isAddNewExerActive: Bool = false
    
    
    // MARK: BODY
    
    var body: some View {
        
        VStack {
            
            DismissButtonView()
            
            Picker("+ Add Exercise", selection: $selection) {
                ForEach(rExerciseVM.exercisePool, id: \.self) { e in
                    Text(e)
                }
            }
            .pickerStyle(.wheel)
            
            HStack {
                
                // Add a new exercise to the routine list
                Button(
                    action: {
                        isAddNewExerActive.toggle()
                    },
                    label: {
                        Text("New")
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 60)
                            .background(
                                Color.gray
                                    .opacity(0.4)
                                    .cornerRadius(8))
                    }
                )
                .padding(.horizontal)
                .sheet(
                    isPresented: $isAddNewExerActive,
                    content: {
                        RExer_AdExerShe_AddNewExerciseSheet(selection: $selection)
                    }
                )
                
                // Add an existed exercise to the routine list
                Button(
                    action: {
                        //exerciseViewModel.addExercise(title: selection)
                        presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Done")
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 60)
                            .background(Color.gray.opacity(0.4))
                            .cornerRadius(8)
                    }
                )
                .padding(.horizontal, 5)
            }   // End of HStack
            
            Spacer()
            
        }   // End of VStack
    }
}


// MARK: PREVIEW

struct AddExerciseButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineExerciseView(isAddExerciseSheetActive: true)
        }
    }
}
