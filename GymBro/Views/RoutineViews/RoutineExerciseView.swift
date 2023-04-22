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
    
    /// Navigation Stack Controller
    @ObservedObject var navStackController = NavigationStackController.instance
    
    /// TabView Controller
    @ObservedObject var tabController = TabController.instance
    
    @State var routineDay: String = "Chest Day"
    @State var showSheet: Bool = false
    
    
    // MARK: BODY
    
    var body: some View {
        
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
                        
                        // Finish routine button
                        /*
                         After finish the routine, it will go to History module, and clean the navigation stack of Routine module
                         */
                        Button(
                            action: {
                                tabController.updateTab(tab: .History)
                                navStackController.popToRoot(module: .Routine)
                            },
                            label: {
                                Text("Finish")
                            }
                        )
                )
            }
        }
}


// MARK: PREVIEW

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineExerciseView()
    }
}
