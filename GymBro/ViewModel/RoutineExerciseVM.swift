//
//  RoutineExerciseVM.swift
//  GymBro
//
//  Created by user239615 on 7/6/23.
//

import Foundation

class RoutineExerciseVM: ObservableObject {
    
    static let instance = RoutineExerciseVM()
    
    /// The exercise one can choose
    @Published var exercisePool: [String] = []

    /// The in progress exercise in the ongoing routine
    @Published var inProgressExercise: [TrainingExerciseModel] = []

    init() {
        getData()
    }
    
    func getData() -> (){
        self.exercisePool = ["Bar Bell Chest", "Bar Bell Up", "Cable Mid", "Cable Low"]
            
        var e1 = TrainingExerciseModel(name: "Bar Bell Chest")
        e1.addSet(weight: 150, reps: 10)
        e1.addSet(weight: 160, reps: 10)
        e1.addSet(weight: 170, reps: 10)
            
        self.inProgressExercise.append(e1)
    }
    
    func addNewExerciseToPool(exerciseName: String) -> () {
        self.exercisePool.append(exerciseName)
    }
        
    func addInProgressExercise(exerciseName: String) -> () {
        let new = TrainingExerciseModel(name: exerciseName)
        self.inProgressExercise.append(new)
    }
    
    func addNewSetToExercise(weight: Int, reps: Int, exercise: TrainingExerciseModel) -> () {
        guard let index = self.inProgressExercise.firstIndex(where: { $0.id == exercise.id }) else { return }
        var exercise = exercise
        exercise.addSet(weight: weight, reps: reps)
        self.inProgressExercise.remove(at: index)
        self.inProgressExercise.insert(exercise, at: index)
    }
    
    func updateSet(weight: Int, reps: Int, exercise: TrainingExerciseModel, trainingSet: TrainingSetModel) {
        guard let exerciseIndex = self.inProgressExercise.firstIndex(where: { $0.id == exercise.id }) else { return }
        guard let setIndex = exercise.setList.firstIndex(where: { $0.id  == trainingSet.id }) else { return }
        var exercise = exercise
            
        let newSet = TrainingSetModel(weight: weight, reps: reps)
        exercise.setList.remove(at: setIndex)
        exercise.setList.insert(newSet, at: setIndex)
            
        self.inProgressExercise.remove(at: exerciseIndex)
        self.inProgressExercise.insert(exercise, at: exerciseIndex)
    }
    
    func newExerciseExist(exerciseName: String) -> Bool {
        return self.inProgressExercise.contains(where: { $0.name == exerciseName } )
    }
    
    /// return the first member from the available exercise
    ///
    /// Provide the default value for the exercise picker
    func getFirstExerciseFromPool() -> String {
        return self.exercisePool.first ?? ""
    }
}

struct TrainingExerciseModel: Identifiable {
    let id = UUID().uuidString
    var setList: [TrainingSetModel] = []
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    mutating func addSet(weight: Int, reps: Int) {
        let newSet = TrainingSetModel(weight: weight, reps: reps)
        self.setList.append(newSet)
    }
}

struct TrainingSetModel: Identifiable {
    let id = UUID().uuidString
    let weight: Int
    let reps: Int
    
    init(weight: Int, reps: Int) {
        self.weight = weight
        self.reps = reps
    }
}
