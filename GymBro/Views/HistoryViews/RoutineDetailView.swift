//
//  RoutineDetailView.swift
//  GymBro
//
//  Created by user236772 on 4/14/23.
//

import SwiftUI

/// Detail for each routine
///
/// The view comes after `IntroHistoryView`
struct RoutineDetailView: View {
    
    
    // MARK: PROPERTY
    
    /// Mock ViewModel Singleton
    @ObservedObject var rDetailViewModel = RDetailViewModel.instance
    
    
    // MARK: BODY
    
    var body: some View {
        List {
            ForEach(rDetailViewModel.data.exerciseList, id: \.id) { exercise in
                Section(header: self.headerWithButton(title: exercise.name)) {
                    Text("Exercise Summary: some stat data for this exercise")
                    ForEach(exercise.exerciseSetList, id: \.id) { exerciseSet in
                        RDetailView_SetRow(element: exerciseSet)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(rDetailViewModel.data.name)
            }
        }
    }
}


// MARK: PREVIEW

struct RoutineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineDetailView()
        }
    }
}


// MARK: COMPONENT

extension RoutineDetailView {

    /// View for `header` parameter in `Section(header: )`
    /// - Parameter title: Header's name
    /// - Returns: A HStack view with name and button leading to `Chart`module.
    func headerWithButton(title: String) -> some View {
        HStack(spacing: 10) {
            Text(title)
                .font(.headline)
            Button(
                action: {
                    rDetailViewModel.goChartModule()
                },
                label: {
                    Image(systemName: "chart.line.uptrend.xyaxis.circle")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                }
            )
        }
        
    }
}

/// Mock view model
class RDetailViewModel: ObservableObject {
    
    @Published var data: RoutineModel = RoutineModel(name: "NONE")
    
    /// TabController
    @ObservedObject var tabController = TabController.instance
    
    static let instance = RDetailViewModel()
    
    init() {
        getData()
    }
    
    func getData() {
        let r = RoutineModel(name: "2/14 Chest 3E 10S 2.5VI")
        
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
    
    func goChartModule() {
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
