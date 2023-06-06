//
//  GymBroApp.swift
//  GymBro
//
//  Created by user236772 on 2/22/23.
//

import SwiftUI

@main
struct GymBroApp: App {
    
    /// The variable that control light mode or daek mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    /// The variable that control the weight unit
    @AppStorage("isLb") private var isLb = true
    
    /// The variable that conrtrol the height unit
    @AppStorage("isFt") private var isFt = true
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
