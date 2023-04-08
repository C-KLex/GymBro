//
//  NewRoutineView.swift
//  GymBro
//
//  Created by user236772 on 4/3/23.
//  The starting page of routine
//  The only function in this view should be a "New Routine" button at the middle of the page

import SwiftUI

struct NewRoutineView: View {
    
    // MARK: BODY
    
    var body: some View {
        VStack{
            NavigationLink {
                Text("RoutineSelectionView")
            } label: {
                newRoutineButton
            }
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
    var newRoutineButton: some View {
        HStack{
            Image(systemName: "plus")
            Text("New Routine")
                .font(.headline)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color.gray)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
}
