//
//  MainView_FiveTab.swift
//  GymBro
//
//  Created by user239615 on 5/1/23.
//

import SwiftUI

/// The tab view for five modules
///
/// Each module has been embeded with a `NavigationView`.
struct MainView_FiveTab: View {
    
    /// TabController
    @ObservedObject var tabController = TabController.instance

    
    // MARK: BODY
    
    var body: some View {
        TabView(selection: $tabController.tabIndex) {
            
            NavigationView {
                MainChartView()
            }
            .tabItem {
                Label("Chart", systemImage: "chart.xyaxis.line")
            }
            .tag(TabController.TabEnum.Chart)
            
            NavigationView {
                IntroHistoryView()
            }
            .tabItem {
                Label("Histroy", systemImage: "book")
            }
            .tag(TabController.TabEnum.History)

            NavigationView {
                NewRoutineView()
            }
            .tabItem {
                Label("Routine", systemImage: "dumbbell")
            }
            .tag(TabController.TabEnum.Routine)

            NavigationView {
                MainInfoView()
            }
            .tabItem {
                Label("Info", systemImage: "person.fill")
            }
            .tag(TabController.TabEnum.Info)

            NavigationView {
                MainSettingView()
            }
            .tabItem {
                Label("Setting", systemImage: "gear")
            }
            .tag(TabController.TabEnum.Setting)
        }
    }
}


// MARK: PREVIEW

struct MainView_FiveTab_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
