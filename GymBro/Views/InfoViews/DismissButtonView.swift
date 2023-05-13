//
//  DismissButtonView.swift
//  GymBro
//
//  Created by user239615 on 5/4/23.
//

import SwiftUI

/// Dismiss Button for all kind of popup sheets
struct DismissButtonView: View {

    @Environment(\.presentationMode) var presentationMode


        // MARK: BODY

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


// MARK: PREVIEW

struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView()
    }
}
