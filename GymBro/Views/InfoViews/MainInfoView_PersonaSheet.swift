//
//  MainInfoView_PersonaSheet.swift
//  GymBro
//
//  Created by user239615 on 5/2/23.
//

import SwiftUI

/// Sheet for setting the user data in Persona Section
///
/// Gathering the Gender, Age, Weight, and Height.
struct MainInfoView_PersonaSheet: View {
    
    
    // MARK: PROPERTY
    
    @Environment(\.presentationMode) var presentationMode
    
    // Required binding variable from `MainInfoView`
    @Binding var gender: String
    @Binding var age: Float
    @Binding var weight: Float
    @Binding var foot: Int
    @Binding var inch: Int
    
    /// Two gender for the Picker
    let genders: [String] = ["Male", "Female"]
    
    
    // MARK: BODY
    
    var body: some View {
        VStack{
            
            // Dismiss icon
            RoundedRectangle(cornerRadius: 4)
                .fill(.black)
                .opacity(0.5)
                .frame(width: 030, height: 4)
                .padding()
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            // Gender
            VStack {
                    Picker("Gender", selection: $gender) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
            }
            .padding()
            .padding(.horizontal)
            
            // Age
            VStack(alignment: .center) {
                Text("Age: \(Int(age))")
                    .font(.title3)
                
                Slider(value: $age, in: 0...100, step: 1.0)
                    .accentColor(.black)
                    
            }
            .padding()
            .padding(.horizontal)
            
            // Weight
            VStack(alignment: .center) {
                Text("Weight: \(Int(weight)) lb")
                    .font(.title3)
                Slider(value: $weight, in: 50...300, step: 1.0)
                    .accentColor(.black)
            }
            .padding()
            .padding(.horizontal)
            
            // Height
            VStack(spacing: 0) {
                Text("Height: \(foot) ft \(inch) in")
                    .font(.title3)
                HStack {
                    Picker("Feet", selection: $foot) {
                        ForEach(3..<9) { foot in
                            Text("\(foot) ft")
                                .tag(foot)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Picker("Inches", selection: $inch) {
                        ForEach(0..<12) { inch in
                            Text("\(inch) in")
                                .tag(inch)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                }
                .frame(width: 250)
                .cornerRadius(25)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 3)
            )
            
            Spacer()
        }
    }
}


// MARK: PREVIEW

struct MainInfoView_PersonaSheet_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView(personaSheetActive: true)
    }
}
