//
//  AddRoutineView.swift
//  GymBro
//
//  Created by user236772 on 4/12/23.
//

import SwiftUI
/// A pop-up sheet in the parent view RoutineSelectionView
///
/// This is a page show up after clicking "+ Add Routine" button in RoutineSelectionVIew. Customer will able to type in their desire name and create a new routine in this page.
///
struct RoutineSelectionView_AddRoutineSheet: View {
    
    
    // MARK: PROPERTY
    
    @Environment(\.presentationMode) var presentationMode
    @State var textFieldText: String  = ""
    
    
    // MARK: BODY
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Type your new routine", text: $textFieldText)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                        .cornerRadius(10)
                    
                    // Check extenstion for the detail implementation
                    saveTextButton
                 }
                 .padding()
            }
            .navigationTitle("Add a Routine")
        }
    }
    
    
    // MARK: METHOD
    
    func saveButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
}


// MARK: PREVIEW

struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineSelectionView_AddRoutineSheet()
    }
}

/// Save button in RoutineSelectionView_AddRoutineSheet
///
/// Tapping the button should create a new routine with the typed in string and close RoutineSelectionView_AddRoutineSheet.
extension RoutineSelectionView_AddRoutineSheet {
    var saveTextButton: some View {
        Button(
            action: {
                saveButtonPressed()
            }, label: {
                Text("Save")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            })
    }
}
