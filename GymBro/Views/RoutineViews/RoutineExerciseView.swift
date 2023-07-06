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
    
    @ObservedObject var rExerciseVM = RoutineExerciseVM.instance
    
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
                    Section(header: self.sectionHeader(title: e.name)) {
                        self.exerciseListRow_SetRow(trainingExercise: e)
                    }
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
    
    /// Section Header
    func sectionHeader(title: String) -> some View {
        VStack {
            Text(title.capitalized)
                .font(.headline)
                .foregroundColor(.black)
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



// MARK: PREVIEW

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineExerciseView()
        }
    }
}
