//
//  NavigationStackController.swift
//  GymBro
//
//  Created by user236772 on 4/20/23.
//

import Foundation

/// Manage the navigation stack.
///
/// In each navigatoinView, there will be a navigation stack to track the view while navigating.
class NavigationStackController: ObservableObject {
    
    /// Two module which need navigation satck.
    ///
    /// - Warning: This can be changed into more case in the future if needed.
    enum moduleEnum {
        case History
        case Routine
    }
    
    /// Singleton
    static let instance = NavigationStackController()
    
    /// Track if Routine module navigation view has other view inside or not.
    ///
    /// In begining, the stack would have only root view, so it is false initially
    @Published var routineNavIsActive: Bool = false
    
    /// Track if History module navigation view has other view in or not.
    ///
    /// In beginning, the stack should have only root view, so it is false initially.
    @Published var historyNavIsActive: Bool = false
    
    /// pop all the view from navigation stack and go back to the root view
    ///
    /// ```
    /// NavigationStackController.popToRoot(module: .History) -> lead to the root view of History Module
    /// ```
    func popToRoot(module: moduleEnum) {
        switch module {
        case .History:
            self.historyNavIsActive = false
        case .Routine:
            self.routineNavIsActive = false
        }
    }
}
