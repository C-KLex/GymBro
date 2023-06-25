//
//  MainChartView.swift
//  GymBro
//
//  Created by user236772 on 4/7/23.
//

import SwiftUI
import Charts

struct MainChartView: View {
    
    
    // MARK: PROPERTY
    
    /// The mock data of bench press
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
    
    /// The chart data that contains all of the current exercise data, which is a list of tuples. Each tuple includes exercise name, mock data and pick. The chart will show the line only if the vairable pick equals true
    let chartData: [(exerciseName: String, data: [weightData], pick: Bool)]
    
    /// Init chartData by init()
    init() {
        chartData = [
            (exerciseName: "Bench Press", data: benchPress, pick: true),
            (exerciseName: "Squats", data: squat, pick: true)
        ]
    }
    
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            GroupBox() {
                Chart {
                    ForEach(chartData, id: \.exerciseName) { series in
                        ForEach(series.data) { item in
                            LineMark(
                                x: .value("Date", item.date),
                                y: .value("Weight", item.weight)
                            )
                            .foregroundStyle(by: .value("Exercise", series.exerciseName))
                            .symbol(by: .value("Exercise", series.exerciseName))
                        }
                        
                    }
                }
                .frame(height: 300)
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month)) { value in
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.month(.defaultDigits))
                    }
                }
            }
            .groupBoxStyle(WhiteGroupBoxStyle())
            .padding()
            
            Spacer()
            
            /// A list that user can pick and show desire exercises
            List {
                ForEach(chartData, id:\.exerciseName) { exercise in
                    HStack {
                        Image(systemName: exercise.pick ? "smallcircle.fill.circle" : "circle")
                        Text(exercise.exerciseName)
                    }
                }
            }
        }
        .navigationTitle("Charts")
    }
}


// MARK: COMPONENT

/// The appearance settings of the chart
struct WhiteGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(.top, 30)
            .padding(20)
            .background(Color.LightGray())
            .cornerRadius(20)
            .overlay(
                configuration.label.padding(10),
                alignment: .topLeading
            )
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


// MARK: PREVIEW

struct MainChartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainChartView()
        }
    }
}
