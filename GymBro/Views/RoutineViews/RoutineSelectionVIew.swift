//
//  RoutineSelectionVIew.swift
//  GymBro
//
//  Created by user236772 on 4/3/23.
//
//  The RoutineSeletionView will show all of the routines that have been used in a list. Customer will be able to click any of them to start a rountine. There will be a button to add new routines.

import SwiftUI

struct RoutineSelectionVIew: View {
    
    @State var routines: [String] = [
        "Leg Day",
        "Breast Day",
        "Back Day",
    ]
    
    @State var addRoutine: Bool = false
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack {
                    Spacer()
                    ForEach(routines, id: \.self) { routine in
                        RoutineItemView(routine: routine)
                            .padding(.all, 5)
                    }
                    Button(action: addButtonPressed, label: {
                        Text("Add Routine")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(width: 350, height: 70)
                            .background(Color.accentColor)
                            .cornerRadius(15)
                    })
                }
                
                .sheet(isPresented: $addRoutine, content: {
                    AddRoutineScreen()
                })
                /*
                if addRoutine {
                    AddRoutineScreen()
                        .transition(.move(edge: .bottom))
                }*/
            })
            .navigationBarBackButtonHidden(false)
            .navigationTitle("Workout Days")
            .navigationBarItems(
                //leading: BackButton()
                trailing: EditButton()
            )
        }
    }
    
    func addButtonPressed() {
        addRoutine.toggle()
    }
}

struct AddRoutineScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var textFieldText: String  = ""
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Type your new routine", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                Button(action: saveButtonPressed, label: {
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
        .padding()
        .navigationTitle("Add an item")
    }
}

struct RoutineSelectionVIew_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineSelectionVIew()
            //AddRoutineScreen()
        }
    }
}

func saveButtonPressed() {
    
}
