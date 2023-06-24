//
//  ChartView.swift
//  GymBro
//
//  Created by user239615 on 6/21/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    let benchPress = [ weightData(year:2023, month:1, day: 1, weight: 100),
                       weightData(year:2023, month:1, day: 5, weight: 105),
                       weightData(year:2023, month:1, day: 9, weight: 110),
                       weightData(year:2023, month:1, day: 13, weight: 115),
                       weightData(year:2023, month:1, day: 17, weight: 120),
                       weightData(year:2023, month:1, day: 21, weight: 125),
                       weightData(year:2023, month:1, day: 25, weight: 130),
                       weightData(year:2023, month:1, day: 29, weight: 130),
                       weightData(year:2023, month:2, day: 2, weight: 135),
                       weightData(year:2023, month:2, day: 6, weight: 140)]
    
    let squat = [ weightData(year:2023, month:1, day: 2, weight: 200),
                       weightData(year:2023, month:1, day: 6, weight: 205),
                       weightData(year:2023, month:1, day: 10, weight: 210),
                       weightData(year:2023, month:1, day: 14, weight: 215),
                       weightData(year:2023, month:1, day: 18, weight: 215),
                       weightData(year:2023, month:1, day: 22, weight: 220),
                       weightData(year:2023, month:1, day: 26, weight: 215),
                       weightData(year:2023, month:1, day: 30, weight: 220),
                       weightData(year:2023, month:2, day: 3, weight: 225),
                       weightData(year:2023, month:2, day: 7, weight: 230)]
    
    let chartData = [
        exerciseData(exerciseName: "Bench Press", data: benchPress, pick: true),
        exerciseData(exerciseName: "Squats", data: squat, pick: true)]
    
    var body: some View {
        VStack {
            
            ForEach(chartData, id: \.self) { series in
                Text(String(1233))
            }
            
            GroupBox() {
                //GroupBox ( "Line Chart - Weight Growing") {
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

struct weightData: Identifiable {
    let id = UUID()
    let date: Date
    let weight: Double

    init(year: Int, month: Int, day: Int, weight: Double) {
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
        self.weight = weight
    }
}

struct exerciseData: Identifiable {
    let id = UUID()
    let exerciseName: String
    let data = [weightData(year: <#Int#>, month: <#Int#>, day: <#Int#>, weight: <#Double#>)]
    let pick: Bool
    
    init(exerciseName: String, data: [weightData], pick: Bool) {
        self.exerciseName = exerciseName
        self.data = data
        self.pick = pick
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChartView()
        }
    }
}
