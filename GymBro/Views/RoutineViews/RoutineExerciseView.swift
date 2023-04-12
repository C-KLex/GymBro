//
//  RoutineView.swift
//  GymBro
//
//  Created by user236772 on 4/3/23.
//
//  It will show the name of routine at the left top. There will also be a list of exercise below that shows all the exercise should be done today. It will need a button to add new exercises. In addition, we can click any exercise block and see a drop down menu shows the weight and reps.


import SwiftUI

struct RoutineExerciseView: View {
    
    
    // MARK: PROPERTY
    
    @State var routineDay: String = "Chest Day"
    @State var showSheet: Bool = false
    

    // MARK: BODY
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    Button("+ Add Exercise", action: {
                        showSheet.toggle()
                    })
                    .sheet(isPresented: $showSheet, content: {
                        AddExerciseButton()
                    })
                    
                }   // End of List
                .navigationTitle(routineDay)
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:

                        // Back to Main view
                        NavigationLink("Finish", destination: MainView())) 
                
            }   // End of VStack

        }   // End of ZStack
        
    }
}


// MARK: PREVIEW

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineExerciseView()
    }
}
