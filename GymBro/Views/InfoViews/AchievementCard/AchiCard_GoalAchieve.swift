//
//  AchiCard_GoalAchieve.swift
//  GymBro
//
//  Created by user239615 on 5/16/23.
//

import SwiftUI

struct AchiCard_GoalAchieve: View {
    
    @ObservedObject var achiCardReg = AchiCardProperty.instance
    
    var body: some View {
        VStack {
            Text("Total Achieve")
                .font(.headline)
                .padding()
            
            Spacer()
            
            Text("4")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("Goal")
                .font(.body)
                .padding()
                
        }
        .frame(width: achiCardReg.cardWidth, height: achiCardReg.cardHeight)
        .background(Color("lightGray"))
        .cornerRadius(achiCardReg.cardCornerRadius)
        .shadow(color: .gray.opacity(0.2), radius: achiCardReg.shadowRadius, x: 0, y: 0)
        .overlay(
            RoundedRectangle(cornerRadius: achiCardReg.cardCornerRadius)
                .stroke(achiCardReg.strokeColor, lineWidth: achiCardReg.strokeLineWidth)
        )
    }
}

struct AchiCard_GoalAchieve_Previews: PreviewProvider {
    static var previews: some View {
        AchiCard_GoalAchieve()
    }
}
