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
    
    /// Mock ViewModel for fake data
    @ObservedObject var chartVM = ChartVM.instance
    
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            GroupBox() {
                Chart {
                    ForEach(chartVM.chartData, id: \.exerciseName) { series in
                        if series.pick {
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
                ForEach($chartVM.chartData, id:\.exerciseName) { $exercise in
                    HStack {
                        Image(systemName: exercise.pick ? "smallcircle.fill.circle" : "circle")
                        Text(exercise.exerciseName)
                    }
                    .onTapGesture {
                        exercise.pick.toggle()
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


// MARK: PREVIEW

struct MainChartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainChartView()
        }
    }
}
