//
//  MainInfoView.swift
//  GymBro
//
//  Created by user236772 on 4/9/23.
//

import SwiftUI

/// Page for Info Module
///
/// It provides the user information, and derived training statistics.
///
/// Section it consists:
/// 1. Percona Section (user basic information)
struct MainInfoView: View {
    
    
    // MARK: PROPERTY
    
    // Persona Section Variable
    @State var personaSheetActive: Bool = false
    @State var gender: String = "NA"
    @State var age: Float = 0.0
    @State var weight: Float = 0.0
    @State var height_foot: Int = 0
    @State var height_inch: Int = 0
        
    
    // MARK: BODY
    
    var body: some View {
        ScrollView {
            
            // To make it long enough to show the crolling view
            self.personaSection()
            self.personaSection()
            self.personaSection()
        }
        .navigationTitle("Personal Information")
    }
}


// MARK: COMPONENT

extension MainInfoView {
    
    /// Persona Section View
    ///
    /// Extract the view code from BDOY to make it tidy.
    ///
    /// - Returns: the whole Persona Section
    func personaSection() -> some View {
        VStack(alignment: .center, spacing: 5) {
            
            // Section headline
            HStack {
                Text("Persona")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "ellipsis")
                    .onTapGesture {
                        personaSheetActive.toggle()
                    }
                    .sheet(isPresented: $personaSheetActive) {
                        MainInfoView_PersonaSheet(gender: $gender, age: $age, weight: $weight, foot: $height_foot, inch: $height_inch)
                    }
                
            }
            .padding(.horizontal, 20)
            
            // The user data grid
            VStack {
                HStack {
                    VStack(alignment: .center, spacing: 10) {
                        Text("Gender")
                        Text(gender)
                    }
                    .padding()
                    .frame(width: 150, height: 150)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
 
                    VStack(alignment: .center, spacing: 10) {
                        Text("Age")
                        Text("\(Int(age))")
                            
                    }
                    .padding()
                    .frame(width: 150, height: 150)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                }
                
                HStack {
                    VStack(alignment: .center, spacing: 10) {
                        Text("Weight")
                        Text("\(Int(weight)) lb")
                    }
                    .padding()
                    .frame(width: 150, height: 150)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Height")
                        Text("\(height_foot) ft \(height_inch) in")
                    }
                    .padding()
                    .frame(width: 150, height: 150)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                }
            }
        }
    }
}


// MARK: PREVIEW

struct MainInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainInfoView()
        }
    }
}
