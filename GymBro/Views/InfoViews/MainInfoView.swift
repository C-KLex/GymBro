//
//  MainInfoView.swift
//  GymBro
//
//  Created by user236772 on 4/9/23.
//

import SwiftUI

/// Page for Infor Module
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
    
    // Goal SectionVariable
    @State var pulseEffect: Bool = false
    @State var goalSheetActive: Bool = false
    @State var newGoalExercise: String = ""
    @State var newProgress: Int = 0
        
    
    // MARK: BODY
    
    var body: some View {
        ScrollView {
            
            self.personaSection()
            self.goalSection()
            self.personaSection()
        }
        .navigationTitle("Personal Information")
    }
}


// MARK: VIEWMODEL
class infoViewModel: ObservableObject {
    static let instance = infoViewModel()
}

struct SimpleProgressBar: View {
    var progress: Double
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: 10)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                Rectangle().frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: 10)
                    .foregroundColor(.green)
            }
        }
    }
}

// MARK: COMPONENT

extension MainInfoView {
    
    func progressBar(progress: Double) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 10)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                    .cornerRadius(20)
                
                Rectangle()
                    .frame(width: min(CGFloat(self.pulseEffect ? progress : progress * 1.05) * geometry.size.width, geometry.size.width), height: 10)
                    .foregroundColor(Color.blue.opacity(self.pulseEffect ? 1 : 0.8))
                    .cornerRadius(20)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                            self.pulseEffect.toggle()
                        }
                    }
            }
        }
    }

    
    func goalSection() -> some View {
        VStack {
            
            HStack {
                Text("Goal")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "plus")
                    .onTapGesture {
                        withAnimation(.spring()) {
                            goalSheetActive.toggle()
                        }
                    }
                    .sheet(isPresented: $goalSheetActive) {
                        MainInfoView_GoalSheet(newGoalExercise: $newGoalExercise, newProgress: $newProgress)
                    }
            }
            .padding(.horizontal, 20)
            
            VStack {
                ScrollView {
                    ForEach(1..<20) { i in
                        
                        HStack {
                            Text("workout")
                            Spacer()
                        }
                        .padding()
                        .background(Color.gray)
                        
                        progressBar(progress: 0.1)
                        
                        
                    }
                }
                .padding(.horizontal, 40)
                .listStyle(.plain)
                .id("goal_list")
                
                
            }
            
            
            
            
        }
    }
    
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
