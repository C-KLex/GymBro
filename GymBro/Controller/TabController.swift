//
//  TabController.swift
//  GymBro
//
//  Created by user236772 on 4/19/23.
//

import Foundation

/// Control the tabView
///
/// Create a singleton ViewModel to control the tabView for all project usage
class TabController: ObservableObject {
    
    /// the enum type for the Tab of tab bar
    enum TabEnum {
        case Chart
        case History
        case Routine
        case Info
        case Setting
    }
    
    /// Singleton
    static let instance = TabController()
    
    /// The tab controller
    @Published var tabIndex: TabEnum
    
    init() {
        self.tabIndex = .Routine
    }
    
    /// Change the tab to different module
    ///
    ///Example:
    /// ```
    /// TabController.updateTab(tab: .Chart) -> turn the tabView to .Chart
    /// ```
    ///
    /// - Parameter tab: go to a different tab module
    func updateTab(tab: TabEnum) {
        self.tabIndex = tab
    }
}
