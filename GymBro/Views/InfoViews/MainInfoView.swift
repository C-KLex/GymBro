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
/// 2. Goal Section( user exercise weight goal)
struct MainInfoView: View {
    
    
    // MARK: PROPERTY
    
    // ViewModel
    @ObservedObject var goalViewModel = GoalViewModel.instance

    // Persona Section Variable
    @State var personaSheetActive: Bool = false
    @State var gender: String = "NA"
    @State var age: Float = 0.0
    @State var weight: Float = 0.0
    @State var height_foot: Int = 0
    @State var height_inch: Int = 0
    
    // Goal Section Variable
    @State var goalSheetActive: Bool = false

    /// The effect itself
    /// 
    /// For withAnimation, animating between true and false  
    @State var pulseEffect: Bool = false
    let pulseAnimation = Animation.easeIn(duration: 1).repeatForever(autoreverses: false)

    /// Control the animation between on and off 
    @State var pulseAnimationIsActive = false

        
    // MARK: BODY
    
    var body: some View {
        ScrollView {
            self.personaSection()
            self.goalSection()
        }
        .navigationTitle("Personal Information")
    }
}


// MARK: VIEWMODEL

/// Mock ViewModel  
class GoalViewModel: ObservableObject {
    
    /// Mock data for the goal section
    /// 
    /// This is for picking the specific exercise for adding the goal
    @Published var exercisePool: [ExerciseTopWeightModel] = []

    /// Mock data for the goal section
    /// 
    /// The goals for the progress bar to show
    @Published var goalList: [GoalModel] = []
    
    static let instance = GoalViewModel()
    
    init() {
        getData()
    }
    
    /// Mock Data
    func getData() -> () {
        let e1 = ExerciseTopWeightModel(exerciseName: "Bar bell bench", topWeight: 120)
        let e2 = ExerciseTopWeightModel(exerciseName: "Squat", topWeight: 300)
        let e3 = ExerciseTopWeightModel(exerciseName: "Cable Pull Down", topWeight: 160)
        self.exercisePool.append(e1)
        self.exercisePool.append(e2)
        self.exercisePool.append(e3)
        
        let g1 = GoalModel(exerciseName: e1.exerciseName, startWeight: e1.topWeight, achieveWeight: 130, goalWeigth: 140)
        let g2 = GoalModel(exerciseName: e2.exerciseName, startWeight: e2.topWeight, achieveWeight: 305, goalWeigth: 350)
        self.goalList.append(g1)
        self.goalList.append(g2)
    }
    
    /// Count the progress percent for the progress bar  
    func getGoalProgress(goalModel: GoalModel) -> Double {
        let divident = Double(goalModel.achieveWeight - goalModel.startWeight)
        let divisor = Double(goalModel.goalWeight - goalModel.startWeight)
        let progressRate = divident / divisor
        return progressRate
    }
    
    /// Add a new goal with the new progress for the specific exercise
    func addGoal(exerciseName: String, progressWeight: Int) -> () {
        let startWeight = self.exercisePool.first(where: { $0.exerciseName == exerciseName })?.topWeight ?? -1
        let goalWeight = startWeight + progressWeight
        let g = GoalModel(exerciseName: exerciseName, startWeight: startWeight, achieveWeight: startWeight, goalWeigth: goalWeight)
        self.goalList.append(g)
    }
}

/// Mock Model
///
/// This is the mock model for the addGoal function
class ExerciseTopWeightModel: Identifiable {
    let id = UUID().uuidString
    let exerciseName: String
    let topWeight: Int
    init(exerciseName: String, topWeight: Int) {
        self.exerciseName = exerciseName
        self.topWeight = topWeight
    }
}

/// Mock Model 
/// 
/// Mock model for the addGoal function
class GoalModel: Identifiable {
    let id = UUID().uuidString
    let exerciseName: String
    let startWeight: Int
    let achieveWeight: Int
    let goalWeight: Int
    init(exerciseName: String, startWeight: Int, achieveWeight: Int, goalWeigth: Int) {
        self.exerciseName = exerciseName
        self.startWeight = startWeight
        self.achieveWeight = achieveWeight
        self.goalWeight = goalWeigth
    }
}


// MARK: COMPONENT

extension MainInfoView {
    
    /// The progressBar in goalSection
    func progressBar(progress: Double) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 10)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                    .cornerRadius(20)
                Rectangle()
                    .frame(width: min(CGFloat(self.pulseEffect ? progress : progress + 0.005) * geometry.size.width, geometry.size.width), height: 10)
                    .foregroundColor(Color.blue)
                    .opacity(self.pulseEffect ? 1 : 0.8)
                    .brightness(self.pulseEffect ? -0.005 : 0.005)
                    .cornerRadius(20)
            }
            .onAppear {
                self.pulseAnimationIsActive = true
            }
            .onChange(of: pulseAnimationIsActive) { isActive in
                if !isActive {
                    withAnimation(.linear(duration: 0)) {
                        self.pulseEffect = false
                    }
                } else {
                    withAnimation(pulseAnimation) {
                        self.pulseEffect = true
                    }
                }
            }
        }
    }

    /// Goal Section View 
    /// 
    /// The goal section title with a list of progress bar.
    /// Hopefully, it can add animation on the progress bar.
    func goalSection() -> some View {
        VStack {
            
            // Goal Section Title and the sheet for adding goal
            HStack {
                Text("Goal")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "plus")
                    .onTapGesture {
                        withAnimation(.spring()) {
                            self.goalSheetActive.toggle()
                        }
                    }
                    .sheet(isPresented: self.$goalSheetActive) {
                        MainInfoView_GoalSheet(pulseAnimationIsActive: self.$pulseAnimationIsActive)
                    }
            }
            .padding(.horizontal, 20)
            
            // List of progress bars
            VStack {
                ScrollView {
                    ForEach(goalViewModel.goalList, id: \.id) { goalModel in

                        let progressRate = goalViewModel.getGoalProgress(goalModel: goalModel)

                        VStack(spacing: 5) {
                            HStack {
                                Text("\(goalModel.exerciseName): %\(Int(progressRate * 100))")
                                Spacer()
                                Text("\(goalModel.goalWeight) lb")
                                    .font(.callout)
                                    .opacity(0.5)
                            }

                            self.progressBar(progress: progressRate)
                        }
                        .padding(.vertical, 1)
                    }
                }
                .padding(.horizontal, 40)
                .listStyle(.plain)
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
