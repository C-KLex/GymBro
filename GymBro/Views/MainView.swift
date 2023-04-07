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

struct MainView: View {
    var body: some View {
        NavigationView {
            TabView {
                // ChartViews module
                Text("chart")
                    .tabItem {
                        Label("Chart", systemImage: "chart.xyaxis.line")
                    }
                    
                // HistoryView module
                Text("History")
                    .tabItem {
                        Label("History", systemImage: "book")
                    }
                
                
                // RoutineViews module
                NewRoutineView()
                    .tabItem {
                        Label("Routine", systemImage: "dumbbell")
                    }
                
                // InfoViews module
                Text("info")
                    .tabItem {
                        Label("Info", systemImage: "person.fill")
                    }
                
                // SettingViews module
                Text("Setting")
                    .tabItem {
                        Label("Setting", systemImage: "gear")
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
