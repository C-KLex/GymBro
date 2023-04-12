//
//  RoutineSelectionVIew.swift
//  GymBro
//
//  Created by user236772 on 4/3/23.
//
//  The RoutineSeletionView will show all of the routines that have been used in a list. Customer will be able to click any of them to start a rountine. There will be a button to add new routines.

import SwiftUI

/// View after NewRoutineView
///
/// This is a page show up after clicking "new routine" button in NewRoutineVIew. Customer will able to select their desire routnie and  add a new blank reoutine in this page. By clicking any one of the routine button, it will link to the correspond RoutineExerciseView.
///
struct RoutineSelectionVIew: View {
    
    
    // MARK: PROPERTY
    
    /// An example list of routines
    @State var routines: [String] = [
        "Leg Day",
        "Chest Day",
        "Back Day",
    ]
    
    /// A variable that determine whether this page should show a pop-up widow for adding a new routine or not
    @State var addRoutine: Bool = false
    
    
    // MARK: BODY
    
    var body: some View {
        List {
            
            // List out all of the current routines
            ForEach(routines, id: \.self) { routine in
                
                // Using overlay is one of the method to avoid the arrow at the right side of navigationLink
                Text(routine)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 20)
                    .frame(height: 80)
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.black
                            .cornerRadius(10))
                    .overlay(NavigationLink(destination: RoutineExerciseView(), label: {
                                        EmptyView()
                                    }))
                    .padding(3)
            }
            .onDelete(perform: deleteRoutine)
            .onMove(perform: moveRoutine)
            .listRowBackground(Color.clear)
                
            // Check extenstion for the detail implementation
            addRoutineButton
        }
        .navigationTitle("Workout Days")
        .navigationBarItems(
            trailing: EditButton()
        )
    }
    
    
    // MARK: METHOD
    
    /// Pop up AddRoutineView after the add button is pressed
    ///  - Returns: Void
    func addButtonPressed() {
        addRoutine.toggle()
    }
    
    /// Delete the routine from the routine list
    ///  - Returns: Voiid
    func deleteRoutine(indextSet: IndexSet) {
        routines.remove(atOffsets: indextSet)
    }
    
    /// Move the routine to desire order in the routine list
    ///  - Returns: Void
    func moveRoutine(index: IndexSet, newOffSet: Int) {
        routines.move(fromOffsets: index, toOffset: newOffSet)
    }
}


// MARK: PREVIEW

struct RoutineSelectionVIew_Previews: PreviewProvider {
    static var previews: some View {
        RoutineSelectionVIew()
    }
}

/// Add Routine button
///
/// Tapping the button should creatpop-up RoutineSelectionView_AddRoutineSheet.
extension RoutineSelectionVIew {
    var addRoutineButton: some View {
        
        // Using HStack to make the button in horizontal center
        HStack {
            Spacer()
            Button(
                action: {
                    addButtonPressed()
                }, label: {
                    Text("+ Add Routine")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal, 70)
                        .background(
                            Color.accentColor
                                .cornerRadius(10)
                        )
                })
            .sheet(isPresented: $addRoutine, content: {
                RoutineSelectionView_AddRoutineSheet()
            })
            Spacer()
        }
        .listRowBackground(Color.clear)
    }
}
