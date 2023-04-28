//
//  IntroHistoryView_ListRow.swift
//  GymBro
//
//  Created by user236772 on 4/19/23.
//

import SwiftUI

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
    
    
    // MARK: PROPERTY
    
    /// init parameter
    @State var element: RoutineSummaryModel
    
    /// Call the mock ViewModel
    @ObservedObject var vm: RoutineRowViewModel = RoutineRowViewModel.instance
    
    /// Alert controller (default is `false`)
    ///
    /// The controller will turn `true` when delete button is clicked, and turn back to `false` when the alert is dismissed
    @State var showDeleteConfirmationAlert: Bool = false
    
    
    // MARK: BODY
    
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
            Image(systemName: "arrowshape.left")
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
                    showDeleteConfirmationAlert = true
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
                    Label("Edit", systemImage: "pencil")
                }
            )
            .tint(.green)
        }
        .alert(isPresented: $showDeleteConfirmationAlert) {
            self.deleteAlert(element: element)
        }
    }
}


// MARK: PREVIEW

struct IntroHistoryView_ListRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            // Parent View
            /*
             The subview will change the parent view directly,
             so I call the parent view 
             */
            IntroHistoryView()
        }
    }
}


// MARK: COMPONENT

extension IntroHistoryView_ListRow {
    
    /// Just an alert.
    ///
    /// Alert pop up when clicking the delete button.
    /// - Parameter element: RoutineSummaryModel
    /// - Returns: An alert view.
    func deleteAlert(element: RoutineSummaryModel) -> Alert{
        Alert(
            title: Text("Delete Routine"),
            message: Text("Are you sure you want to delete this routine? This action cannot be undone."),
            primaryButton: .destructive(Text("Delete")) {
                vm.deleteItem(element: element)
            },
            secondaryButton: .cancel()
        )
    }
}
