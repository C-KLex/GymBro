//
//  RoutineView.swift
//  GymBro
//
//  Created by user236772 on 4/3/23.
//
//  It will show the name of routine at the left top. There will also be a list of exercise below that shows all the exercise should be done today. It will need a button to add new exercises. In addition, we can click any exercise block and see a drop down menu shows the weight and reps.


import SwiftUI

struct RoutineExerciseView: View {
    
    
    // MARK: PROPERTY
    
    @ObservedObject var rExerciseVM = RoutineExerciseViewModel.instance
    
    /// Navigation Stack Controller
    @ObservedObject var navStackController = NavigationStackController.instance
    
    /// TabView Controller
    @ObservedObject var tabController = TabController.instance
    
    /// Routine day shown as title.
    @State var routineDay: String = "Chest Day"
    
    /// Show the exercise wheel picker if "+ Add Exercise" button is pressed.
    @State var isAddExerciseSheetActive: Bool = false
    
    
    // MARK: BODY
    
    var body: some View {
        
        VStack {
            
            List {
                
                Button("+ Add Exercise", action: {
                    isAddExerciseSheetActive.toggle()
                })
                .sheet(isPresented: $isAddExerciseSheetActive, content: {
                    RExercise_AddExerciseSheet()
                })
                
            }
            .navigationTitle(routineDay)
            .navigationBarItems(
                leading: EditButton(),
                trailing: self.finishButton()
            )
        }
    }
}


// MARK: COMPONENT

extension RoutineExerciseView {
    func finishButton() -> some View {
        Button(
            action: {
                tabController.updateTab(tab: .History)
                navStackController.popToRoot(module: .Routine)
            },
            label: {
                Text("Finish")
            }
        )
    }
}


// MARK: VIEWMODEL
class RoutineExerciseViewModel: ObservableObject {
    
    static let instance = RoutineExerciseViewModel()
    
    @Published var exercisePool: [String] = []
    
    init() {
        getData()
    }
    
    func getData() {
        self.exercisePool = ["Bar Bell Chest", "Bar Bell Up", "Cable Mid", "Cable Low"]
    }
    
    func addNewExerciseToPool(exerciseName: String) {
        self.exercisePool.append(exerciseName)
        for name in self.exercisePool {
            print(name)
        }
    }
}

class TrainingExerciseModel: Identifiable {
    let id = UUID().uuidString
    var setList: [TrainingSetModel] = []
    let name: String
    init(name: String) {
        self.name = name
    }
    
    func addSet(weight: Int, reps: Int) {
        let newSet = TrainingSetModel(weight: weight, reps: reps)
        self.setList.append(newSet)
    }
}

class TrainingSetModel: Identifiable {
    let id = UUID().uuidString
    let weight: Int
    let reps: Int
    init(weight: Int, reps: Int) {
        self.weight = weight
        self.reps = reps
    }
}





// MARK: PREVIEW

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineExerciseView()
        }
    }
}
