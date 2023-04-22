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
    
    // control which tab it is right now
    @ObservedObject var tabController = TabController.instance
    
    
    // MARK: BODY
    
    var body: some View {
        
        VStack {
            FiveTabView(selectedTab: $tabController.tabIndex)
        }
    }
}


// MARK: PREVIEW

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


// MARK: COMPONENT

/// The tab view for five modules
///
/// Thing to do:
/// 1. How to extend the showing View from only one View to multiple view in one tab
/// - Warning: I will keep the view in the MainView for a while for a better arrangement!
struct FiveTabView: View {

    /// Tab controller
    ///
    /// When using the FiveTabView, you need to assign which default tab it is right now.
    @Binding var selectedTab: TabController.TabEnum

    var body: some View {
        TabView(selection: $selectedTab) {

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
