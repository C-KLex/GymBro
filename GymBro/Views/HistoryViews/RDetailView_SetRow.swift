//
//  RDetailView_SetRow.swift
//  GymBro
//
//  Created by user236772 on 4/27/23.
//

import SwiftUI

/// Show each set detail of the exercise in a list row view
///
/// ```
/// RDetailView_SetRow(element: ExerciseSetModel)
/// ```
struct RDetailView_SetRow: View {
    
    
    // MARK: PROPERTY
    
    /// Init Parameter
    let element: ExerciseSetModel
    
    
    // MARK: BODY
    
    var body: some View {
        HStack {
            Text("\(element.weight) lb")
            Text("\(element.repetition) rep")
        }
    }
}


// MARK: PREVIEW

struct RDetailView_SetRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineDetailView()
        }
    }
}
