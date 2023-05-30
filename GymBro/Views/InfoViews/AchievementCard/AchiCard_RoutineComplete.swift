//
//  AchiCard_RoutineComplete.swift
//  GymBro
//
//  Created by user239615 on 5/16/23.
//

import SwiftUI

struct AchiCard_RoutineComplete: View {
    
    @ObservedObject var achiCardReg = AchiCardProperty.instance
    
    var body: some View {
        VStack {
            Text("Complete")
                .font(.headline)
                .padding()
            
            Spacer()
            
            Text("60")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("Routines")
                .font(.body)
                .padding()
        }
        .frame(width: achiCardReg.cardWidth, height: achiCardReg.cardHeight)
        .background(Color("lightGray"))
        .cornerRadius(achiCardReg.cardCornerRadius)
        .shadow(color: achiCardReg.shadowColor, radius: achiCardReg.shadowRadius, x: 0, y: 0)
        .overlay(
            RoundedRectangle(cornerRadius: achiCardReg.cardCornerRadius)
                .stroke(achiCardReg.strokeColor, lineWidth: achiCardReg.strokeLineWidth)
        )
    }
}

struct AchiCard_RoutineComplete_Previews: PreviewProvider {
    static var previews: some View {
        AchiCard_RoutineComplete()
    }
}
