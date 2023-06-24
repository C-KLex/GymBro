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
    
    
    // MARK: PROPERTY
    
    /// Mock ViewModel for fake data
    @ObservedObject var introHisVM = IntroHistoryVM.instance
    
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            List {
                
                // introHisVM.routineSummaryData
                /*
                 It represents the summary data of each routine
                 */
                ForEach(introHisVM.routineSummaryData, id: \.id) { element in
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
