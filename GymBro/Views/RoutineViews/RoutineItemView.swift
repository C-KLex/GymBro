//
//  RoutineItemView.swift
//  GymBro
//
//  Created by user236772 on 4/9/23.
//

import SwiftUI

struct RoutineItemView: View {
    
    let routine: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.white)
                .frame(width: 350, height: 100)
                .shadow(radius: 2)
            
            Text(routine)
                .font(.title2)
                .padding(.vertical, 8)
                .foregroundColor(Color.black
                )
        }
        
    }
}

struct RoutineItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoutineItemView(routine: "Bench Press")
        }
        .previewLayout(.sizeThatFits)
    }
}
