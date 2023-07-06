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
    
    @ObservedObject var rExerciseVM = RoutineExerciseVM.instance
    @Environment(\.presentationMode) var presentationMode
    
    /// Binding Variable for picker selection
    @State var selection: String = ""
    @State var isAddNewExerActive: Bool = false
    @State var isExerciseAlertActive: Bool = false 
    
    
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
                        RExer_AdExerShe_AddNewExerciseSheet()
                    }
                )
                
                // Add an existed exercise to the routine list
                HStack {
                    Text("Add")
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 60)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 5)
                .onTapGesture {
                    self.addButtonAction()
                }
                .alert(isPresented: self.$isExerciseAlertActive) {
                    self.exerciseAlert(exerciseName: self.selection)
                }
                
                
            }
            
            Spacer()
        }   // End of VStack
    }
}


// MARK: COMPONENT

extension RExercise_AddExerciseSheet {
    
    func exerciseAlert(exerciseName: String) -> Alert {
        Alert(
            title: Text("Error!!!").foregroundColor(.red),
            message: Text("\(exerciseName) is in progress already!"),
            dismissButton: .default(Text("OK"))
        )
    }
    
    func addButtonAction() -> () {
        
        // check if empty
        if self.selection == "" {
            let defaultExercise = rExerciseVM.getFirstExerciseFromPool()
            selection = defaultExercise
        }
        
        // check duplicate exercise or not
        if rExerciseVM.newExerciseExist(exerciseName: selection) {
            self.isExerciseAlertActive = true
            return
        }
        
        // add a new inProgressExercise
        rExerciseVM.addInProgressExercise(exerciseName:selection)
        
        // dismiss
        presentationMode.wrappedValue.dismiss()
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
