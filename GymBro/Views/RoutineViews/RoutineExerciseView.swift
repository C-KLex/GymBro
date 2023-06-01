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
                
                ForEach(rExerciseVM.inProgressExercise, id: \.id) { e in
                    Rexercise_ExerciseListRow(trainingExercise: e)
                }
                
                
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
    @Published var inProgressExercise: [TrainingExerciseModel] = []
    
    init() {
        getData()
    }
    
    func getData() {
        self.exercisePool = ["Bar Bell Chest", "Bar Bell Up", "Cable Mid", "Cable Low"]
        
        var e1 = TrainingExerciseModel(name: "Bar Bell Chest")
        e1.addSet(weight: 150, reps: 10)
        e1.addSet(weight: 160, reps: 10)
        e1.addSet(weight: 170, reps: 10)
        
        self.inProgressExercise.append(e1)
    }
    
    func addNewExerciseToPool(exerciseName: String) -> () {
        self.exercisePool.append(exerciseName)
    }
    
    func addInProgressExercise(exerciseName: String) -> () {
        let new = TrainingExerciseModel(name: exerciseName)
        self.inProgressExercise.append(new)
    }
    
    func getFirstExerciseFromPool() -> String {
        return self.exercisePool.first ?? ""
    }
    
    func addNewSetToExercise(weight: Int, reps: Int, exercise: TrainingExerciseModel) {
        guard let index = self.inProgressExercise.firstIndex(where: { $0.id == exercise.id }) else { return }
        var exercise = exercise
        
        print(exercise.setList)
        
        exercise.addSet(weight: weight, reps: reps)
        
        print(exercise.setList)
        self.inProgressExercise.remove(at: index)
        self.inProgressExercise.insert(exercise, at: index)
        
        print(self.inProgressExercise)
    }
    
    func updateSet(weight: Int, reps: Int, exercise: TrainingExerciseModel, trainingSet: TrainingSetModel) {
        
    }
       
}

struct TrainingExerciseModel: Identifiable {
    let id = UUID().uuidString
    var setList: [TrainingSetModel] = []
    let name: String
    init(name: String) {
        self.name = name
    }
    
    mutating func addSet(weight: Int, reps: Int) {
        let newSet = TrainingSetModel(weight: weight, reps: reps)
        self.setList.append(newSet)
    }
}

struct TrainingSetModel: Identifiable {
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
