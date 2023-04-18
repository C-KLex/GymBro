//
//  RoutineDetailView.swift
//  GymBro
//
//  Created by user236772 on 4/14/23.
//

import SwiftUI

struct RoutineDetailView: View {
    
    // MARK: PROPERTY
    @ObservedObject var vm = DetailViewModel.instance
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            Text("RoutineDetail")
            Button("Button") {
                print(vm.data)
                print(vm.data.exerciseList)
            }
        }
        .navigationTitle("Detail")
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

class DetailViewModel: ObservableObject {
    
    @Published var data: RoutineDetail = RoutineDetail(name: "NONE")
    
    static let instance = DetailViewModel()
    
    init() {
        getData()
    }
    
    func getData() {
        let r = RoutineDetail(name: "Chest")
        let e1 = Exercise(name: "Barbell Bench")
        let e2 = Exercise(name: "Dumbell up chest")
        e1.addExerciseSet(weight: 200, repetition: 10)
        e1.addExerciseSet(weight: 250, repetition: 8)
        e1.addExerciseSet(weight: 300, repetition: 6)
        e1.addExerciseSet(weight: 350, repetition: 4)
        e2.addExerciseSet(weight: 200, repetition: 5)
        e2.addExerciseSet(weight: 225, repetition: 5)
        e2.addExerciseSet(weight: 250, repetition: 5)
        e2.addExerciseSet(weight: 150, repetition: 5)
        r.exerciseList.append(e1)
        r.exerciseList.append(e2)
        self.data = r
    }
    
}

class RoutineDetail: Identifiable {
    let id = UUID().uuidString
    let name: String
    @Published var exerciseList: [Exercise] = []
    
    init(name: String) {
        self.name = "Chest Day"
    }

    func addExercise(name: String) {
        let newExercise: Exercise = Exercise(name: name)
        self.exerciseList.append(newExercise)
    }
}

class Exercise: Identifiable {
    let id = UUID().uuidString
    let name: String
    var exerciseSetList: [ExerciseSet] = []
    
    init(name: String) {
        self.name = name
    }
    
    func addExerciseSet(weight: Int, repetition: Int) {
        let newSet: ExerciseSet = ExerciseSet(weight: weight, repetition: repetition)
        self.exerciseSetList.append(newSet)
    }
    
    func removeExerciseSet(element: ExerciseSet) {
        self.exerciseSetList.removeAll { $0.id == element.id }
    }
}

class ExerciseSet: Identifiable {
    let id = UUID().uuidString
    let unit: String = "lb"
    var weight: Int = 0
    var repetition: Int = 0
    
    init(weight: Int, repetition: Int) {
        self.weight = weight
        self.repetition = repetition
    }
}

