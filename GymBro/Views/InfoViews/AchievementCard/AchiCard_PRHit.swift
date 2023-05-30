//
//  AchiCard_PRHit.swift
//  GymBro
//
//  Created by user239615 on 5/16/23.
//

import SwiftUI

struct AchiCard_PRHit: View {
    
    @ObservedObject var achiCardReg = AchiCardProperty.instance
    
    var body: some View {
        VStack {
            Text("New PR")
                .font(.headline)
                .padding()
            
            Spacer()
            
            Text("300 lb")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("Bar Bell Chest")
                .font(.callout)
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

struct AchiCard_PRHit_Previews: PreviewProvider {
    static var previews: some View {
        AchiCard_PRHit()
    }
}
