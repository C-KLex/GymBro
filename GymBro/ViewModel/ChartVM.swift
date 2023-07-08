//
//  ChartVM.swift
//  GymBro
//
//  Created by user239615 on 7/6/23.
//

import Foundation
import SwiftUI

class ChartVM: ObservableObject {
    
    static let instance = ChartVM()
    
    //@Published var chartData: [(exerciseName: String, data: [weightData], pick: Bool)] = []
    
    @Published var chartData: [ExerciseData] = []
    
    
    init() {
        getData()
    }
    /*
    func getData() -> () {
        let benchPress: [weightData] = [
            weightData(year:2023, month:1, day: 1, weight: 100),
            weightData(year:2023, month:1, day: 5, weight: 105),
            weightData(year:2023, month:1, day: 9, weight: 110),
            weightData(year:2023, month:1, day: 13, weight: 115),
            weightData(year:2023, month:1, day: 17, weight: 120),
            weightData(year:2023, month:1, day: 21, weight: 125),
            weightData(year:2023, month:1, day: 25, weight: 130),
            weightData(year:2023, month:1, day: 29, weight: 130),
            weightData(year:2023, month:2, day: 2, weight: 135),
            weightData(year:2023, month:2, day: 6, weight: 140)
        ]
        
        /// The mock data of squat
        let squat: [weightData] = [
            weightData(year:2023, month:1, day: 2, weight: 200),
            weightData(year:2023, month:1, day: 6, weight: 205),
            weightData(year:2023, month:1, day: 10, weight: 210),
            weightData(year:2023, month:1, day: 14, weight: 215),
            weightData(year:2023, month:1, day: 18, weight: 215),
            weightData(year:2023, month:1, day: 22, weight: 220),
            weightData(year:2023, month:1, day: 26, weight: 215),
            weightData(year:2023, month:1, day: 30, weight: 220),
            weightData(year:2023, month:2, day: 3, weight: 225),
            weightData(year:2023, month:2, day: 7, weight: 230)
        ]
        
        let data = [
            (exerciseName: "Bench Press", data: benchPress, pick: true),
            (exerciseName: "Squats", data: squat, pick: true)
        ]
        
        self.chartData = data
    }
     */
    
    func getData() -> () {
        let benchPress: [weightData] = [
            weightData(year:2023, month:1, day: 1, weight: 100),
            weightData(year:2023, month:1, day: 5, weight: 105),
            weightData(year:2023, month:1, day: 9, weight: 110),
            weightData(year:2023, month:1, day: 13, weight: 115),
            weightData(year:2023, month:1, day: 17, weight: 120),
            weightData(year:2023, month:1, day: 21, weight: 125),
            weightData(year:2023, month:1, day: 25, weight: 130),
            weightData(year:2023, month:1, day: 29, weight: 130),
            weightData(year:2023, month:2, day: 2, weight: 135),
            weightData(year:2023, month:2, day: 6, weight: 140)
        ]
        
        /// The mock data of squat
        let squat: [weightData] = [
            weightData(year:2023, month:1, day: 2, weight: 200),
            weightData(year:2023, month:1, day: 6, weight: 205),
            weightData(year:2023, month:1, day: 10, weight: 210),
            weightData(year:2023, month:1, day: 14, weight: 215),
            weightData(year:2023, month:1, day: 18, weight: 215),
            weightData(year:2023, month:1, day: 22, weight: 220),
            weightData(year:2023, month:1, day: 26, weight: 215),
            weightData(year:2023, month:1, day: 30, weight: 220),
            weightData(year:2023, month:2, day: 3, weight: 225),
            weightData(year:2023, month:2, day: 7, weight: 230)
        ]
        
        let data = [
            ExerciseData(exerciseName: "Bench Press", data: benchPress, pick: true),
            ExerciseData(exerciseName: "Squats", data: squat, pick: true)
        ]
        
        self.chartData = data
    }
}


/// The structure of exercise, might be different in the future
struct weightData: Identifiable {
    let id = UUID()
    let date: Date
    let weight: Double

    init(year: Int, month: Int, day: Int, weight: Double) {
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
        self.weight = weight
    }
}


struct ExerciseData: Identifiable {
    let id = UUID()
    let data: [weightData]
    let exerciseName: String
    let pick: Bool

    init(exerciseName: String, data: [weightData], pick: Bool) {
        self.exerciseName = exerciseName
        self.data = data
        self.pick = pick
    }
}
