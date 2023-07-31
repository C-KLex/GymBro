//
//  RoutineSelectionVM.swift
//  GymBro
//
//  Created by user239615 on 7/27/23.
//

import Foundation
import SwiftUI

class RoutineSelectionVM: ObservableObject {
    
    static let instance = RoutineSelectionVM()
    
    /// The exercise one can choose
    @Published var routinePool: [String] = []
    
    init() {
        getData()
    }
    
    func getData() -> () {
        self.routinePool = ["Leg Day", "Chest Day", "Back Day"]
    }
    
    /// Pop up AddRoutineView after the add button is pressed
    ///  - Returns: Void
    func addNewRoutine(routineName: String) -> () {
        self.routinePool.append(routineName)
    }
    
    /// Delete the routine from the routine list
    ///  - Returns: Voiid
    func deleteRoutine(indextSet: IndexSet) -> () {
        self.routinePool.remove(atOffsets: indextSet)
    }
    
    /// Move the routine to desire order in the routine list
    ///  - Returns: Void
    func moveRoutine(index: IndexSet, newOffSet: Int) {
        self.routinePool.move(fromOffsets: index, toOffset: newOffSet)
    }
}


