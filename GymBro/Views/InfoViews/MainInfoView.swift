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
    @State var userAvatarAnimation: Bool = false
    @State var shadowAnimation: Bool = false
        
    
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
            HStack(spacing: 5) {
                
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)], spacing: 2) {
                    VStack(alignment: .center, spacing: 10) {
                        Text(gender)
                    }
                    .padding()
                    .frame(width: 75, height: 100)
                    .background(Color("lightGray"))
                    .cornerRadius(10)
 
                    VStack(alignment: .center, spacing: 0) {
                        Text("\(age)")
                        Text("yr")
                    }
                    .padding(9)
                    .frame(width: 75, height: 100)
                    .background(Color("lightGray"))
                    .cornerRadius(10)
                    
                    VStack(alignment: .center, spacing: 0) {
                        Text("\(Int(weight))")
                        Text("lb")
                    }
                    .padding(9)
                    .frame(width: 75, height: 100)
                    .background(Color("lightGray"))
                    .cornerRadius(10)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("\(heightFoot)'\(heightInch)")
                    }
                    .padding()
                    .frame(width: 75, height: 100)
                    .background(Color("lightGray"))
                    .cornerRadius(10)
                }
                
                ZStack {
                    Image("strongBear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotationEffect(Angle(degrees: self.userAvatarAnimation ? 0 : 1))
                        .frame(width: self.userAvatarAnimation ? 140 : 141)
                        .cornerRadius(10)
                        
                }
                .frame(width: 150)
                .frame(maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .onAppear {
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                        self.userAvatarAnimation = true
                    }
                    withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                        self.shadowAnimation = true
                    }
                }
                .shadow(color: .red, radius: 2, x: self.shadowAnimation ? -2 : 2, y: self.shadowAnimation ? -2 : 2)
            }
            .padding(.horizontal, 40)
            
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
