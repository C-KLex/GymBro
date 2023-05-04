//
//  MainInfoView_GoalSheet.swift
//  GymBro
//
//  Created by user239615 on 5/4/23.
//

import SwiftUI

struct MainInfoView_GoalSheet: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var newGoalExercise: String
    @Binding var newProgress: Int
    private let newProgressArray = Array(stride(from: 0, to: 100, by: 5))

    var body: some View {
        
        
        VStack {
            
            DismissButtonView()
            
            HStack {
                Text("Pick A Exercise")
                    .font(.headline)
                
                Picker("progress", selection: $newGoalExercise) {
                    ForEach(3..<9) { foot in
                        Text("\(foot) ft")
                            .tag(foot)
                    }
                }
                .pickerStyle(.wheel)
            }
            .padding(.horizontal)
            
            HStack(alignment: .center) {
                    Text("New Progress")
                
                Picker("progress", selection: $newProgress) {
                    ForEach(newProgressArray, id: \.self) { number in
                        Text("+ \(number)")
                    }
                }
                .pickerStyle(.wheel)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        
        
    }
}

struct MainInfoView_GoalSheet_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView(goalSheetActive: true)
    }
}
