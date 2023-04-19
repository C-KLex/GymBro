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
    
    /// Mock ViewModel for fake data
    @ObservedObject var vm = RoutineRowViewModel.instance
    
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            List {
                
                // vm.routineSummaryData
                /*
                 It represents the summary data of each routine
                 */
                ForEach(vm.routineSummaryData, id: \.id) { element in
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

/// The list row sub view for IntroHistoryView
///
/// swipteAction, delete and edit
///
/// navLink, lead to RoutineDetailView for each
///
/// ```
/// IntroHistoryView_ListRow(element: RoutineSummaryModel)
/// ```
struct IntroHistoryView_ListRow: View {
    
    /// init parameter
    @State var element: RoutineSummaryModel
    
    /// Call the mock ViewModel
    @ObservedObject var vm: RoutineRowViewModel = RoutineRowViewModel.instance
    
    /// Control for the navigationLink
    @State private var isActive: Bool = false
    
    var body: some View {
        HStack {
            Text(element.date)
            Text(element.routineName)
            
            Spacer()
            Text("\(element.totalExercise) E")
            Text("\(element.totalSet) S")
            Text(String(format: "%.2f", element.trainingVolume) + " VI")
            Image(systemName: "hand.tap")
                .foregroundColor(.gray)
            
            Spacer()
            Image(systemName: "chevron.left")
                .foregroundColor(.gray)
        }
        .background(
            NavigationLink(
                destination: RoutineDetailView(),
                label: { EmptyView() }
            )
            .opacity(0)
        )
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(
                action: {
                    vm.deleteItem(element: element)
                },
                label: {
                    Label("Delete", systemImage: "trash")
                }
            )
            .tint(.red)

            Button(
                action: {
                    vm.editItem(element: element)
                },
                label: {
                    Label("Edit", systemImage: "restart")
                }
            )
            .tint(.green)
        }
    }
}
