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
    
    /// init parameter
    @State var element: RoutineSummaryModel
    
    /// Call the mock ViewModel
    @ObservedObject var vm: RoutineRowViewModel = RoutineRowViewModel.instance
    
    /// Control for the navigationLink
    @State private var isActive: Bool = false
    
    
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
