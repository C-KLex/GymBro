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
    @ObservedObject var rDetailVM = RoutineDetailVM.instance
    
    
    // MARK: BODY
    
    var body: some View {
        List {
            ForEach(rDetailVM.data.exerciseList, id: \.id) { exercise in
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
                Text(rDetailVM.data.name)
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
                    rDetailVM.goChartModule()
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

