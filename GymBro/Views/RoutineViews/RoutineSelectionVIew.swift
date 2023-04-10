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
    
    var body: some View {
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
        })
        .navigationBarBackButtonHidden(false)
        .navigationTitle("Workout Days")
        .navigationBarItems(
            //leading: BackButton()
            trailing: EditButton()
        )
    }
    
    func addButtonPressed() {
        
    }
}

struct RoutineSelectionVIew_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineSelectionVIew()
        }
    }
}
