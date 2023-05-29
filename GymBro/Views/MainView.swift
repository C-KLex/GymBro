//
//  MainView.swift
//  GymBro
//
//  Created by user236772 on 4/3/23.
//
//  The MainView file should at the top of all other views.
//  It should support the function of switching between different views by "TabView".
//  Reference: https://www.youtube.com/watch?v=TgvYFfCjDMo

import SwiftUI

/// The very first view after starting the APP
struct MainView: View {
    
    /// TabController
    @ObservedObject var tabController = TabController.instance
    
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            MainView_FiveTab()
        }
    }
}


// MARK: PREVIEW

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
