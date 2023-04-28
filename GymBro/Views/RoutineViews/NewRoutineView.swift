//
//  NewRoutineView.swift
//  GymBro
//
//  Created by user236772 on 4/3/23.
//  The starting page of routine
//  The only function in this view should be a "New Routine" button at the middle of the page

import SwiftUI

/// The very first view of Routine Module
///
/// Open a new routine if there is no current running routin
struct NewRoutineView: View {
    
    
    // MARK: PROPERTY
    
    /// newRoutineButton color
    @State var newRoutineButtonColor = Color.gray
    
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            NavigationLink(
                destination: {
                    RoutineSelectionVIew()
                },
                label: {
                    newRoutineButton
                }
            )
        }
    }
}


// MARK: PREVIEW

struct NewRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewRoutineView()
        }
    }
}


// MARK: COMPONENT

extension NewRoutineView {
    
    /// newRoutineButton
    var newRoutineButton: some View {
        HStack{
            Image(systemName: "plus")
            Text("New Routine")
                .font(.headline)
                .fontWeight(.bold)
        }
        .padding()
        .background(newRoutineButtonColor)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}
