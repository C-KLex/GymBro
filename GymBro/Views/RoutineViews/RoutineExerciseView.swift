//
//  RoutineView.swift
//  GymBro
//
//  Created by user236772 on 4/3/23.
//
//  It will show the name of routine at the left top. There will also be a list of exercise below that shows all the exercise should be done today. It will need a button to add new exercises. In addition, we can click any exercise block and see a drop down menu shows the weight and reps.


import SwiftUI

/// Writing down the training detail
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
    
    /// Set detail row controller
    @State var showSet: Bool = false
    
    // sheet controller
    @State var showAddSetSheet: Bool = false
    @State var showUpdateSetSheet: Bool = false
    
    // binding variable for picker
    @State var selectedWeight: Int = 120
    @State var selectedReps: Int = 5
    
    
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
                    self.exerciseListRow(trainingExercise: e)
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
    
    /// Exercise row
    ///
    /// Provide each in progress exercise and show detail of each set
    func exerciseListRow(trainingExercise: TrainingExerciseModel) -> some View {
        VStack {
            HStack {
                Text(trainingExercise.name)
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack {
                    self.showSet ? Image(systemName: "chevron.down") : Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    self.showSet.toggle()
                }
            }
            
            if self.showSet {
                self.exerciseListRow_SetRow(trainingExercise: trainingExercise)
            }   // End if showSet
        }
    }
    
    /// Set row
    ///
    /// The set of the exercise
    func exerciseListRow_SetRow(trainingExercise: TrainingExerciseModel) -> some View {
        VStack(spacing: 5) {
            ForEach(trainingExercise.setList, id: \.id) { s in
                HStack {
                    Text("\(s.weight) lb")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .frame(width: 90)
                        .background(Color.gray.cornerRadius(10).opacity(0.2))
                    
                    Spacer()
                    
                    Text("\(s.reps) reps")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .frame(width: 90)
                        .background(Color.gray.cornerRadius(10).opacity(0.2))
                }
                .padding(.horizontal)
                .onTapGesture {
                    self.updateWeightReps(weight: s.weight, reps: s.reps)
                    self.showUpdateSetSheet = true
                }
                .sheet(isPresented: self.$showUpdateSetSheet) {
                    RExercise_SetRow_UpdateSetSheet(selectedWeight: self.$selectedWeight, selectedRep: self.$selectedReps, trainingExercise: trainingExercise, trainingSet: s)
                }
                
            }
            
            HStack {
                Text("+ Add Set")
            }
            .onTapGesture {
                self.showAddSetSheet = true
            }
            .sheet(isPresented: $showAddSetSheet) {
                RExercise_SetRow_AddSetSheet(selectedWeight: self.$selectedWeight, selectedRep: self.$selectedReps, trainingExercise: trainingExercise)
            }
        }
    }
    
    /// The Finish routine button on the top left conrner of the view
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
    
    /// Update the binding variable for the picker
    func updateWeightReps(weight: Int, reps: Int) -> () {
        self.selectedWeight = weight
        self.selectedReps = reps
    }
}


// MARK: VIEWMODEL

/// Mock VM
class RoutineExerciseViewModel: ObservableObject {
    
    static let instance = RoutineExerciseViewModel()
    
    /// The exercise one can choose
    @Published var exercisePool: [String] = []
    
    /// The in progress exercise in the ongoing routine
    @Published var inProgressExercise: [TrainingExerciseModel] = []
    
    init() {
        getData()
    }
    
    func getData() -> (){
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
    
    /// return the first member from the available exercise
    ///
    /// Provide the default value for the exercise picker
    func getFirstExerciseFromPool() -> String {
        return self.exercisePool.first ?? ""
    }
    
    func addNewSetToExercise(weight: Int, reps: Int, exercise: TrainingExerciseModel) -> () {
        guard let index = self.inProgressExercise.firstIndex(where: { $0.id == exercise.id }) else { return }
        var exercise = exercise
        exercise.addSet(weight: weight, reps: reps)
        self.inProgressExercise.remove(at: index)
        self.inProgressExercise.insert(exercise, at: index)
    }
    
    func updateSet(weight: Int, reps: Int, exercise: TrainingExerciseModel, trainingSet: TrainingSetModel) {
        guard let exerciseIndex = self.inProgressExercise.firstIndex(where: { $0.id == exercise.id }) else { return }
        guard let setIndex = exercise.setList.firstIndex(where: { $0.id  == trainingSet.id }) else { return }
        var exercise = exercise
        
        let newSet = TrainingSetModel(weight: weight, reps: reps)
        exercise.setList.remove(at: setIndex)
        exercise.setList.insert(newSet, at: setIndex)
        
        self.inProgressExercise.remove(at: exerciseIndex)
        self.inProgressExercise.insert(exercise, at: exerciseIndex)
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
