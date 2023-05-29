//
//  SettingView_ReportIssueSheet.swift
//  GymBro
//
//  Created by user236772 on 4/20/23.
//

import SwiftUI

struct SettingView_ReportIssueSheet: View {
    
    
    // MARK: PROPERTY
    
    @Environment(\.presentationMode) var presentationMode
    
    /// A url variable to store issue title
    @State var issueTitle: String  = ""
    
    /// A url variable to store issue content
    @State var issueContent: String  = ""
    
    // MARK: BODY
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Issue Title")
                    Spacer()
            }
            TextField("", text:$issueTitle)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .cornerRadius(10)
            HStack{
                Text("Issue Content")
                Spacer()
            }
            
            TextEditor(text:$issueContent)
                .frame(height: 300)
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .cornerRadius(10)
            
                    
            sendTextButton
            Spacer()
        }
        .padding()
        .navigationTitle("Report Issue")
    }
    
    
    // MARK: METHOD
    
    /// Drop down the ReportIssueSheet_Previews after the save button is pressed
    ///  - Returns: Void
    func sendButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: PREVIEW

struct SettingView_ReportIssueSheet_Previews: PreviewProvider {
    static var previews: some View {
        SettingView_ReportIssueSheet()
    }
}

extension SettingView_ReportIssueSheet {
    
    /// Send text button in RoutineSelectionView_AddRoutineSheet
    ///
    /// Tapping the button should send data/email back to server.
    var sendTextButton: some View {
        Button(
            action: {
                sendButtonPressed()
            }, label: {
                Text("Send")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            })
    }
}
