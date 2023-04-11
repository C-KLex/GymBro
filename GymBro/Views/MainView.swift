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
    
    /// The control variable for the FiveTabView
    ///
    /// It will change the defualt view of the tab view inside the FiveTabView
    @State private var selectedTab: Tab = .Routine
    
    
    // MARK: BODY
    
    var body: some View {
        FiveTabView(selectedTab: selectedTab)
    }
}


// MARK: PREVIEW

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


// MARK: COMPONENT

/// the enum type for the Tab of tab bar
///
/// - Warning: I will keep this enum Tab in MainView for a while for researching a better arrangement
enum Tab {
    case Chart
    case History
    case Routine
    case Info
    case Setting
}

/// The tab view for five modules
///
/// Thing to do:
/// 1. How to extend the showing View from only one View to multiple view in one tab
/// - Warning: I will keep the view in the MainView for a while for a better arrangement!
struct FiveTabView: View {

    /// Tab controler
    ///
    /// A required parameter when init FiveTabView
    @State var selectedTab: Tab

    var body: some View {
        TabView(selection: $selectedTab) {

            NavigationView {
                MainChartView()
            }
            .tabItem {
                Label("Chart", systemImage: "chart.xyaxis.line")
            }
            .tag(Tab.Chart)

            NavigationView {
                IntroHistoryView()
            }
            .tabItem {
                Label("Histroy", systemImage: "book")
            }
            .tag(Tab.History)

            NavigationView {
                NewRoutineView()
            }
            .tabItem {
                Label("Routine", systemImage: "dumbbell")
            }
            .tag(Tab.Routine)

            NavigationView {
                MainInfoView()
            }
            .tabItem {
                Label("Info", systemImage: "person.fill")
            }
            .tag(Tab.Info)

            NavigationView {
                MainSettingView()
            }
            .tabItem {
                Label("Setting", systemImage: "gear")
            }
            .tag(Tab.Setting)

        }
    }
}
