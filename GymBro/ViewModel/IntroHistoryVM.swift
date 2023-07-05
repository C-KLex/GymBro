//
//  IntroHistoryVM.swift
//  GymBro
//
//  Created by user239615 on 6/23/23.
//

import Foundation
import SwiftUI

/// Viewmodel for `IntroHistoryView`
class IntroHistoryVM: ObservableObject {
    
    @Published var routineSummaryData: [RoutineSummaryModel] = []
    
    static let instance = IntroHistoryVM()
    
    init() {
        getData()
    }
    
    func getData() -> () {
        for i in stride(from: 28, through: 1, by: -1) {
            let row: RoutineSummaryModel = RoutineSummaryModel(date: "02/\(i)", routineName: "chest", totalExercise: 4, totalSet: 4, trainingVolume: 2.5)
            routineSummaryData.append(row)
        }
    }
    
    /// Delete routine from the presention row list
    func deleteRoutine(element: RoutineSummaryModel) -> () {
        routineSummaryData.removeAll { $0.id == element.id }
    }
    
    /// Edit the specifi routine
    func editRoutine(element: RoutineSummaryModel) -> () {
        print("edit \(element.id)")
    }
}

class RoutineSummaryModel: Identifiable {
    
    let id = UUID().uuidString
    let date: String
    let routineName: String
    let totalExercise: Int
    let totalSet: Int
    let trainingVolume: Float
    
    init(date: String, routineName: String, totalExercise: Int, totalSet: Int, trainingVolume: Float) {
        self.date = date
        self.routineName = routineName
        self.totalExercise = totalExercise
        self.totalSet = totalSet
        self.trainingVolume = trainingVolume
    }
}
