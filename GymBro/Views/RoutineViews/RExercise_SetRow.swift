//
//  RExercise_SetRow.swift
//  GymBro
//
//  Created by 陳宜葳 on 5/23/23.
//
//  This is the view for user to check what's already in the exercise list.

import SwiftUI

struct RExercise_SetRow: View {
    
    
    // MARK: PROPERTY
    
    /// The exercise of each row. Should be an input from RoutineExerciseView.
    var exercise: String
    
    /// The weight list has been added.
    @State var weightList: [Int] = [120, 110, 110]
    
    /// The rep list has been added.
    @State var repList: [Int] = [10, 15, 15]
    
    /// Show the drop down set list.
    @State var showSet: Bool = false
    
    /// Show the EditSetView as a pop-up sheet
    @State var showEditSheet: Bool = false
    
    
    // MARK: BODY
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text(exercise)
                    .foregroundColor(.black)
                Spacer()
                
                HStack {
                    self.showSet ? Image(systemName: "chevron.down") : Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    self.showSet.toggle()
                }
                    
            }
            
            if showSet {
                
                VStack {
                    ForEach(0..<3) { index in
                        HStack {
                            Text("\(weightList[index]) lb")
                                .padding(5)
                                .padding(.horizontal, 30)
                                .background(Color.gray.cornerRadius(10).opacity(0.2))
                            Spacer()
                            Text("\(repList[index]) reps")
                                .padding(5)
                                .padding(.horizontal, 30)
                                .background(Color.gray.cornerRadius(10).opacity(0.2))
                        }
                        .padding(.horizontal)
                        .onTapGesture {
                            showEditSheet = true
                        }
                    }
                    
                    HStack {
                        Text("+ Add Set")
                    }
                    .onTapGesture {
                        showEditSheet = true
                    }
                 
                    
                }
                .sheet(isPresented: $showEditSheet) {
                    RExercise_SetRow_EditSetSheet()
                }
                
            }   // End if showSet
        }   // End of VStack
            
    }
}


// MARK: PREVIEW

struct ShowSetsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineExerciseView()
        }
    }
}
