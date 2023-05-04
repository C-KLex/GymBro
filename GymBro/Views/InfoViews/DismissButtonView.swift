//
//  DismissButtonView.swift
//  GymBro
//
//  Created by user239615 on 5/4/23.
//

import SwiftUI

struct DismissButtonView: View {
    @Environment(\.presentationMode) var presentationMode
        var body: some View {
            RoundedRectangle(cornerRadius: 4)
                .fill(.black)
                .opacity(0.5)
                .frame(width: 30, height: 4)
                .padding()
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
}

struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView()
    }
}
