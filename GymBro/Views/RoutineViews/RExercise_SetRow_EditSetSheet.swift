//
//  RExercise_SetRow_EditSetSheet.swift
//  GymBro
//
//  Created by Claire on 4/27/23.
//
//  This view is a pop-up sheet. Two pickers for selecting weights and reps.

import SwiftUI

struct RExercise_SetRow_EditSetSheet: View {
    
    
    // MARK: PROPERTY
    
    /// Weight to be selected. Set default as 120 lb.
    @State var selectedWeight: Int = 120
    
    /// Rep to be selected. Set default as 5.
    @State var selectedRep: Int = 5
    
    /// Show wheel pickers when click the title of exercises.
    @State var showPicker: Bool = false
    
    
    // MARK: BODY
    
    var body: some View {
            
        
        VStack {
            
            DismissButtonView()
            
            HStack {
                
                Picker("Select Weight", selection: $selectedWeight) {
                    ForEach(10...200, id: \.self) { weight in
                        if weight % 5 == 0 {
                            Text("\(weight) lb").tag("\(weight)")
                        }
                    }
                }
                .pickerStyle(.wheel)
                
                Picker("Select Rep", selection: $selectedRep) {
                    ForEach(1...15, id: \.self) { rep in
                        Text("\(rep)").tag("\(rep)")
                    }
                }
                .pickerStyle(.wheel)
            }
            .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            
            Spacer()
        }
    }
}


// MARK: PREVIEW

struct EditSetView_Previews: PreviewProvider {
    
    static var previews: some View {
        RExercise_SetRow(exercise: "", showSet: true, showEditSheet: true)
    }
}
