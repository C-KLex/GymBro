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
    @State var age: Int = 0
    @State var weight: Float = 0.0
    @State var heightFoot: Int = 0
    @State var heightInch: Int = 0
    @State var userName: String = ""
        
    
    // MARK: BODY
    
    var body: some View {
        ScrollView {
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
                Image(systemName: "figure.run")
                    .font(.title)
                
                Text(self.userName != "" ? self.userName : "Persona")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .onTapGesture {
                        personaSheetActive.toggle()
                    }
                    .sheet(isPresented: $personaSheetActive) {
                        ScrollView {
                            MainInfoView_PersonaSheet(gender: $gender, age: $age, weight: $weight, foot: $heightFoot, inch: $heightInch, userName: $userName)
                        }
                    }
                
            }
            .padding(.horizontal, 20)
            
            // The user data grid
            VStack {
                HStack {
                    VStack(alignment: .center, spacing: 10) {
                        Text(gender)
                    }
                    .padding()
                    .frame(width: 75, height: 75)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
 
                    VStack(alignment: .center, spacing: 0) {
                        Spacer()
                        Text("\(age)")
                        Text("yr")
                    }
                    .padding(9)
                    .frame(width: 75, height: 75)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    
                    VStack(alignment: .center, spacing: 0) {
                        Spacer()
                        Text("\(Int(weight))")
                        Text("lb")
                    }
                    .padding(9)
                    .frame(width: 75, height: 75)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("\(heightFoot)'\(heightInch)")
                    }
                    .padding()
                    .frame(width: 75, height: 75)
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
