//
//  MainSettingView.swift
//  GymBro
//
//  Created by user236772 on 4/7/23.
//

import SwiftUI

struct MainSettingView: View {
    
    
    // MARK: PROPERTY
    
    
    /// The variable that control light mode or daek mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    /// The variable that control the weight unit
    @AppStorage("isLb") private var isLb = true
    
    /// The variable that conrtrol the height unit
    @AppStorage("isFt") private var isFt = true
    
    /// A variable that authorized  to apple watch, need furture improvement
    @State var appleWatchIsOn: Bool = false
    
    /// A variable that authorized to apple health, need furture improvement
    @State var appleHealthIsOn: Bool = false
    
    /// A variable taht will set timer on after each set is finish, need future improvement
    @State var timerIsOn: Bool = false
    
    /// A url link to app stroe of GrmBro
    @State var urlToAppStore =  "itms-apps://itunes.apple.com/developer/id463855590"
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            List {
                
                /// First section is some pickerthat user can choose
                Section("Unit") {
                    Picker("weightunit", selection: $isLb) {
                        Text("lb")
                            .tag(true)
                        Text("kg")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("heightunit", selection: $isFt) {
                        Text("ft")
                            .tag(true)
                        Text("cm")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                /// Second section is osme switch
                Section() {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                    Toggle("Apple Watch", isOn: $appleWatchIsOn)
                    Toggle("Apple Health", isOn: $appleHealthIsOn)
                    Toggle("Timer", isOn: $timerIsOn)
                }
                
                /// Third section will toggle some subview
                Section() {
                    Text("Notification")
                        .overlay(NavigationLink(destination: SettingView_NotificationSettingView(), label: {
                                            EmptyView()
                                        }))
                    Text("Help Center")
                        .overlay(NavigationLink(destination: SettingView_HelpCenterView(), label: {
                                            EmptyView()
                                        }))
                    Text("Report Issue")
                        .overlay(NavigationLink(destination: SettingView_ReportIssueSheet(), label: {
                                            EmptyView()
                                        }))
                        
                    
                    Link("Rate this App",
                         destination: .init(string: "https://itunes.apple.com")!)
                    .foregroundColor(Color.ForegroundTitle())
                    
                    Text("Export Data")
                        .overlay(NavigationLink(destination: SettingView_ExportDataView(), label: {
                                            EmptyView()
                                        }))
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Settings")
        .foregroundColor(Color.ForegroundTitle())
        .background(Color.Background())
    }
}


// MARK: PREVIEW

struct MainSettingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MainSettingView()
            }
            .colorScheme(.light)
        }
        Group {
            NavigationView {
                MainSettingView()
            }
            .colorScheme(.dark)
        }
    }
}
