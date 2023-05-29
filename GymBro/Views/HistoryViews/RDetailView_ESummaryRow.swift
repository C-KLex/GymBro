//
//  RDetailView_ESummaryRow.swift
//  GymBro
//
//  Created by user236772 on 4/28/23.
//

import SwiftUI

/// Exercise Summary Information View
/// 
/// Provide a summary, for example, total set, total exercise, and total exercise, etc.
/// 
/// - Warning: Need to discuss what to show as the summary.
struct RDetailView_ESummaryRow: View {
    
    
    // MARK: BODY
    
    var body: some View {
        Text("This is summary row: 3e6s1.2vi")
    }
}


// MARK: PREVIEW

struct RDetailView_ESummaryRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineDetailView()
        }
    }
}
