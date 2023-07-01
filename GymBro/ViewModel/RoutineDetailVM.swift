//
//  RoutineDetailVM.swift
//  GymBro
//
//  Created by user239615 on 6/28/23.
//

import Foundation
import SwiftUI

/// ViewModel for `RoutineDetailView`
class RoutineDetailVM: ObservableObject {
        
    static let instance = RoutineDetailVM()
    
    @Published var data: RoutineModel = RoutineModel(name: "NONE")
    
    @ObservedObject var tabController = TabController.instance
    
    init() {
        getData()
    }
    
    func getData() -> () {
        
        let r = RoutineModel(name: "2/14 Chest 3E 10S 2.5 VI")
        
        for _ in 0...5 {
            
            let e1 = ExerciseModel(name: "Barbell Bench")
            
            for _ in 0...2 {
                
                e1.addExerciseSet(weight: 200, repetition: 10)
                e1.addExerciseSet(weight: 250, repetition: 8)
                e1.addExerciseSet(weight: 300, repetition: 6)
                e1.addExerciseSet(weight: 350, repetition: 4)
            }
            
            r.exerciseList.append(e1)
        }
        
        self.data = r
    }
    
    func goChartModule() -> () {
        tabController.updateTab(tab: .Chart)
    }
    
}

/// Mock Model
class RoutineModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    @Published var exerciseList: [ExerciseModel] = []
    
    init(name: String) {
        self.name = name
    }
}

/// Mock Model
class ExerciseModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    var exerciseSetList: [ExerciseSetModel] = []
    
    init(name: String) {
        self.name = name
    }
    
    func addExerciseSet(weight: Int, repetition: Int) {
        let newSet: ExerciseSetModel = ExerciseSetModel(weight: weight, repetition: repetition)
        self.exerciseSetList.append(newSet)
    }
    
    func removeExerciseSet(element: ExerciseSetModel) {
        self.exerciseSetList.removeAll { $0.id == element.id }
    }
}

/// Mock Model
class ExerciseSetModel: Identifiable {
    let id = UUID().uuidString
    let unit: String
    let weight: Int
    let repetition: Int
    
    init(weight: Int, repetition: Int) {
        self.unit = "lb"
        self.weight = weight
        self.repetition = repetition
    }
}
