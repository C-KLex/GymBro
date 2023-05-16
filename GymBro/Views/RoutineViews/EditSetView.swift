//
//  EditSetView.swift
//  GymBro
//
//  Created by Claire on 4/27/23.
//
//  This view is a pop-up sheet

import SwiftUI

struct EditSetView: View {
    
    
    // MARK: PROPERTY
    
    /// The exercise of each row. Should be an input from RoutineExerciseView.
    var exercise: String
    
    /// Weight to be selected. Set default as 120 lb.
    @State var selectedWeight: Int = 120
    
    /// Rep to be selected. Set default as 5.
    @State var selectedRep: Int = 5
    
    /// Show wheel pickers when click the title of exercises.
    @State var showPicker: Bool = false
    
    
    // MARK: BODY
    
    var body: some View {
            
        /// Two column pickers view (if click on an exercise in the list)
        VStack (alignment: .leading, spacing: 4) {
            Button {
                showPicker.toggle()
            } label: {
                HStack {
                    Text(exercise)
                        .foregroundColor(.black)
                    Spacer()
                    showPicker ? Image(systemName: "chevron.down") : Image(systemName: "chevron.right")
                }
            }
            
            if showPicker {
                HStack {
                    /// Wheel picker for weight, range from 10 to 200 lb
                    /// Initial weight: 120 lb
                    Picker("Select Weight", selection: $selectedWeight) {
                        ForEach(10...200, id: \.self) { weight in
                            if weight % 5 == 0 {
                                Text("\(weight) lb").tag("\(weight)")
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    /// Wheel picker for rep, range from 1 to 15
                    /// Initial rep: 5
                    Picker("Select Rep", selection: $selectedRep) {
                        ForEach(1...15, id: \.self) { rep in
                            Text("\(rep)").tag("\(rep)")
                        }
                    }
                    .pickerStyle(.wheel)
                }   // End of HStack
                .padding(.vertical, 2)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            }
        }   // End of VStack
    }
}


// MARK: PREVIEW

struct EditSetView_Previews: PreviewProvider {
    
    //static var exercise = "Bar Bell Up"
    
    static var previews: some View {
        //EditSetView(exercise: exercise)
        NavigationView {
            RoutineExerciseView()
        }
    }
}
