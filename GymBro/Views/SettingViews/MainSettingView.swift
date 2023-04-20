//
//  MainSettingView.swift
//  GymBro
//
//  Created by user236772 on 4/7/23.
//

import SwiftUI

struct MainSettingView: View {
    
    @State var isLightMode: Bool = true
    @State var isLB: Bool = true
    @State var isFt: Bool = true
    
    @State var appleWatchIsOn: Bool = false
    @State var appleHealthIsOn: Bool = false
    @State var timerIsOn: Bool = false
    
    @State var reportIssue: Bool = false
    
    var body: some View {
        VStack {
            List {
                
                Section() {
                    HStack {
                        Text("Theme")
                        Spacer()
                        Picker("theme", selection: $isLightMode) {
                            Text("Light")
                                .tag(true)
                            Text("Dark")
                                .tag(false)
                        }
                        .frame(width: 150)
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    HStack {
                        Text("Weight Unit")
                        Spacer()
                        Picker("weightunit", selection: $isLB) {
                            Text("lb")
                                .tag(true)
                            Text("kg")
                                .tag(false)
                        }
                        .frame(width: 150)
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    HStack {
                        Text("Height Unit")
                        Spacer()
                        Picker("heightunit", selection: $isFt) {
                            Text("ft")
                                .tag(true)
                            Text("cm")
                                .tag(false)
                        }
                        .frame(width: 150)
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section() {
                    Toggle("Apple Watch", isOn: $appleWatchIsOn)
                    Toggle("Apple Health", isOn: $appleHealthIsOn)
                    Toggle("Timer", isOn: $timerIsOn)
                }
                
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
                    Text("Rate this App")
                        .overlay(NavigationLink(destination: SettingView_RateTheAppView(), label: {
                                            EmptyView()
                                        }))
                    Text("Export Data")
                        .overlay(NavigationLink(destination: SettingView_ExportDataView(), label: {
                                            EmptyView()
                                        }))
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Settings")
    }
}

struct MainSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainSettingView()
        }
    }
}
