//
//  MainInfoView_PersonaSheet.swift
//  GymBro
//
//  Created by user239615 on 5/2/23.
//

import SwiftUI

/// Sheet for setting the user data in Persona Section
///
/// Gathering the Gender, Age, Weight, Height, and UserName.
struct MainInfoView_PersonaSheet: View {
    
    
    // MARK: PROPERTY
    
    @Environment(\.presentationMode) var presentationMode
    
    // Required binding variable from `MainInfoView`
    @Binding var gender: String
    @Binding var age: Int
    @Binding var weight: Float
    @Binding var foot: Int
    @Binding var inch: Int
    @Binding var userName: String
    
    // For birthday section
    @State private var birthdate = Date()
    private let maxDate = Date()
    private let minDate: Date = {
            var components = DateComponents()
            components.year = Calendar.current.component(.year, from: Date()) - 100
            return Calendar.current.date(from: components)!
        }()
    private let pickerWidth: CGFloat = 330.0
    
    /// Two gender for the Picker
    let genders: [String] = ["♂", "♀"]
    
    
    // MARK: BODY
    
    var body: some View {
        VStack(spacing: 10){
            DismissButtonView()
            userNameTextField()
            genderPicker()
            birthdayPicker()
            weightSlider()
            heightPicker()
            Spacer()
        }
    }
}


// MARK: COMPONENT

extension MainInfoView_PersonaSheet{
    
    /// Calculate the age from birthdate.
    ///
    /// Update the binding var `age`
    func updateAge() -> () {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
        self.age = ageComponents.year ?? 0
    }
    
    /// User Name Section
    func userNameTextField() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("User Name")
                .font(.title3)
            
            TextField("Enter your name...", text: $userName)
                .textFieldStyle(.roundedBorder)
                .frame(width: self.pickerWidth)
        }
    }
    
    /// Gender Section
    func genderPicker() -> some View {
        VStack(alignment: .leading, spacing: 0) {
                Text("Gender")
                    .font(.title3)
            
                Picker("Gender", selection: $gender) {
                    ForEach(genders, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: self.pickerWidth)
        }
    }
    
    /// Birthday, Age Section
    func birthdayPicker() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Birthday")
                .font(.title3)
            
            DatePicker("Select your birthdate", selection: self.$birthdate, in: minDate...maxDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .labelsHidden()
                .onChange(of: birthdate) { _ in
                    updateAge()
                }
                .frame(width: self.pickerWidth)
        }
    }
    
    /// Weight Section
    func weightSlider() -> some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text("\(Int(weight)) lb")
                .font(.title3)
            Slider(value: $weight, in: 50...300, step: 1.0)
                .accentColor(.black)
                .frame(width: self.pickerWidth)
        }
    }
    
    /// Height Section 
    func heightPicker() -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(foot) ft \(inch) in")
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
            .frame(width: self.pickerWidth)
        }
    }    
}

// MARK: PREVIEW

struct MainInfoView_PersonaSheet_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView(personaSheetActive: true)
    }
}
