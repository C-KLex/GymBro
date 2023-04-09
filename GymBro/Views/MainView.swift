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

enum Tab {
    case Chart
    case History
    case Routine
    case Info
    case Setting
}

struct MainView: View {
    
    @State private var selectedTab: Tab = .Routine
    
    var body: some View {
        NavigationView {
            FiveTabView(selectedTab: selectedTab)
        }
    }
}

struct FiveTabView: View {
    
    @State var selectedTab: Tab
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // ChartViews module
            MainChartView()
                .tabItem {
                    Label("Chart", systemImage: "chart.xyaxis.line")
                }
                .tag(Tab.Chart)
            
            // HistoryView module
            IntroHistoryView()
                .tabItem {
                    Label("History", systemImage: "book")
                }
                .tag(Tab.History)
            
            
            // RoutineViews module
            NewRoutineView()
                .tabItem {
                    Label("Routine", systemImage: "dumbbell")
                }
                .tag(Tab.Routine)
            
            // InfoViews module
            MainInfoView()
                .tabItem {
                    Label("Info", systemImage: "person.fill")
                }
                .tag(Tab.Info)
            
            // SettingViews module
            MainSettingView()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
                .tag(Tab.Setting)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
