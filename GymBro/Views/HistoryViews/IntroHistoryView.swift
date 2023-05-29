//
//  IntroHistoryView.swift
//  GymBro
//
//  Created by user236772 on 4/9/23.

import SwiftUI

/// Very first view of History module
///
/// It consits with a list of history routine record
struct IntroHistoryView: View {
    
    
    // MARK: PROPERTY
    
    /// Mock ViewModel for fake data
    @ObservedObject var routineRowVM = RoutineRowViewModel.instance
    
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            List {
                
                // routineRowVM.routineSummaryData
                /*
                 It represents the summary data of each routine
                 */
                ForEach(routineRowVM.routineSummaryData, id: \.id) { element in
                    IntroHistoryView_ListRow(element: element)
                    
                }
            }
        }
        .navigationTitle("History")
    }
}


// MARK: PREVIEW

struct IntroHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            IntroHistoryView()
        }
    }
}


// MARK: COMPONENT

/// Mock Model for RoutineRowViewModel, which is mock too
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

/// Mock ViewModel
///
/// It could be a reference in the future when building the real ViewModel
class RoutineRowViewModel: ObservableObject {
    
    /// A list of RoutineSummaryModel
    @Published var routineSummaryData: [RoutineSummaryModel] = []
    
    /// Singleton
    static let instance = RoutineRowViewModel()
    
    private init() {
        getData()
    }
    
    /// Generate the mocking data
    func getData() {
        for i in stride(from: 28, through: 1, by: -1) {
            let row: RoutineSummaryModel = RoutineSummaryModel(date: "02/\(i)", routineName: "chest", totalExercise: 4, totalSet: 4, trainingVolume: 2.5)
            routineSummaryData.append(row)
        }
    }
    
    /// Delete
    ///
    /// It only work on the mock data
    ///
    /// - Parameter element: RoutineSumaryModel
    func deleteItem(element: RoutineSummaryModel) {
        routineSummaryData.removeAll { $0.id == element.id }
    }
    
    /// Edit the selected training routine
    ///
    /// It will navigate into the RoutineExerciseView in Routine module
    ///
    /// - Parameter element: RoutineSummaryModel
    func editItem(element: RoutineSummaryModel) {
        print("edit \(element.id)")
    }
}


