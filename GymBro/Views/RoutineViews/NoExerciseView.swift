//
//  NoExerciseView.swift
//  GymBro
//
//  Created by 陳宜葳 on 4/28/23.
//

import SwiftUI

struct NoExerciseView: View {
    
    
    // MARK: PROPERTY
    
    /// Routine day shown as title.
    @State var routineDay: String = "Chest Day"
    
    /// Show the exercise wheel picker if "+ Add Exercise" button is pressed.
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
            }
        }
        .navigationTitle(routineDay)
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Finish", destination: MainView()))  // Back to Main view
        
    }
}


// MARK: PREVIEW

struct NoExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoExerciseView()
        }
    }
}
