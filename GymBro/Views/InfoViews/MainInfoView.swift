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
/// 2. Goal Section( user exercise weight goal)
struct MainInfoView: View {
    
    
    // MARK: PROPERTY
    
    // ViewModel
    @ObservedObject var goalVM = GoalViewModel.instance

    // Persona Section Variable //
    @State var personaSheetActive: Bool = false
    @State var gender: String = "NA"
    @State var age: Int = 0
    @State var weight: Float = 0.0
    @State var heightFoot: Int = 0
    @State var heightInch: Int = 0
    @State var userName: String = ""
        
    // Goal Section Variable //
    // sheet control
    @State var goalSheetActive: Bool = false
    @State var sheetExerciseName: String = ""
    @State var sheetProgress: Int = -1

    // Animation Control
    
    /// The effect itself
    @State var pulseEffect: Bool = false

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
    
    /// Count the progress percent for the progress bar
    /// - Parameter goalModel: give a goalModel with start weight and the achieved weight right now
    /// - Returns: A double for the progress rate between 0 to 1
    func getGoalProgress(goalModel: GoalModel) -> Double {
        let divident = Double(goalModel.achieveWeight - goalModel.startWeight)
        let divisor = Double(goalModel.goalWeight - goalModel.startWeight)
        let progressRate = divident / divisor
        return progressRate
    }
    
    /// Check if the goal exists before adding a new goal
    /// - Parameter exerciseName: the exercise desired to add as a new goal
    /// - Returns: Bool
    func isGoalExist(exerciseName: String) -> Bool {
        return self.goalList.contains(where: { $0.exerciseName == exerciseName })
    }
    
    /// Calculate the progress for update goal, it's similar to `getGoalProgress`, but it's not the same scenario
    func calculateProgress(goal: GoalModel) -> Int {
        let progress = goal.goalWeight - goal.startWeight
        return progress
    }
    
    /// Calculate the goal weight
    /// - Parameter startWeight: the base line of the exercise weight
    /// - Parameter progressWeight: the weight one would like to improve
    /// - Returns: the goal weight
    func calculateGoalWeight(startWeight: Int, progressWeight: Int) -> Int {
        return startWeight + progressWeight
    }
    
    /// Mock Data
    func getData() -> () {
        let e1 = ExerciseTopWeightModel(exerciseName: "Bar bell bench", topWeight: 120)
        let e2 = ExerciseTopWeightModel(exerciseName: "Squat", topWeight: 300)
        let e3 = ExerciseTopWeightModel(exerciseName: "Cable Pull Down", topWeight: 160)
        self.exercisePool.append(e1)
        self.exercisePool.append(e2)
        self.exercisePool.append(e3)
        let g1 = GoalModel(exerciseName: self.exercisePool[0].exerciseName, startWeight: self.exercisePool[0].topWeight, achieveWeight: 130, goalWeigth: 140)
        self.goalList.append(g1)
        let g2 = GoalModel(exerciseName: self.exercisePool[1].exerciseName, startWeight: self.exercisePool[1].topWeight, achieveWeight: 305, goalWeigth: 350)
        self.goalList.append(g2)
    }
    
    /// update a specific goal to the goalList
    func updateGoal(goal: GoalModel, newProgress: Int) -> () {
        guard let index = self.goalList.firstIndex(where: { $0.id == goal.id }) else { return }
        let updatedGoal = GoalModel(
            exerciseName: goal.exerciseName,
            startWeight: goal.startWeight,
            achieveWeight: goal.achieveWeight,
            goalWeigth: self.calculateGoalWeight(startWeight: goal.startWeight, progressWeight: newProgress)
        )
        self.goalList.remove(at: index)
        self.goalList.insert(updatedGoal, at: index)
    }
    
    /// Add a new GoalModel to the goalList
    func addGoal(exerciseName: String, progressWeight: Int) -> () {
        let startWeight = self.exercisePool.first(where: { $0.exerciseName == exerciseName })?.topWeight ?? -1
        let g = GoalModel(exerciseName: exerciseName, startWeight: startWeight, achieveWeight: startWeight, goalWeigth: self.calculateGoalWeight(startWeight: startWeight, progressWeight: progressWeight))
        self.goalList.append(g)
    }
    
    /// delete a goal from the goalList
    func deleteGoal(goal: GoalModel) -> () {
        self.goalList.removeAll(where: { $0.id == goal.id } )
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
    
    /// Goal Section View
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
                            self.goalSheetActive = true 
                        }
                    }
                    .sheet(isPresented: self.$goalSheetActive) {
                        MainInfoView_GoalSheet(
                            isUpdateGoal: false,
                            pulseAnimationIsActive: self.$pulseAnimationIsActive,
                            newGoalExercise: self.$sheetExerciseName,
                            newProgress: self.$sheetProgress
                        )
                    }
            }
            .padding(.horizontal, 20)
            
            // List of progress bars
            VStack {
                ScrollView {
                    ForEach(self.goalVM.goalList, id: \.id) { goal in
                        MainInfoView_GoalListRow(
                            goal: goal,
                            pulseEffect: self.$pulseEffect,
                            pulseAnimationIsActive: self.$pulseAnimationIsActive,
                            sheetExerciseName: self.$sheetExerciseName,
                            sheetProgress: self.$sheetProgress
                        )
                    }
                }
                .padding(.horizontal, 40)
                .listStyle(.plain)
            }
        }
    }
    
    /// Persona Section View
    func personaSection() -> some View {
        VStack(alignment: .center, spacing: 5) {
            
            // Section headline
            HStack {
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
