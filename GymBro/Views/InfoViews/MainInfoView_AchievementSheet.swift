//
//  MainInfoView_AchievementSheet.swift
//  GymBro
//
//  Created by user239615 on 5/8/23.
//

import SwiftUI

struct MainInfoView_AchievementSheet: View {
    
    @ObservedObject var achieveOptVM = AchievementOptionsViewModel.instance
    var body: some View {
        VStack {
            DismissButtonView()
            
            HStack {
                Text("What to Show 👀")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal)
            
            List {
                ForEach(achieveOptVM.options, id: \.id) { optionModel in
                    HStack {
                        
                        
                        self.checkIcon()
                            .onTapGesture {
                            }
                        
                        Text(optionModel.optionName)
                            .font(.title2)
                        
                        
                        Spacer()
                    }
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
    }
}

extension MainInfoView_AchievementSheet{
    func checkIcon() -> some View {
        Image(systemName: "checkmark.square.fill").foregroundColor(.green)
    }
    
    func unCheckIcon() -> some View {
        Image(systemName: "square").foregroundColor(.gray)
    }
}

class AchievementOptionsViewModel: ObservableObject {
    @Published var options: [optionModel] = []
    static let instance = AchievementOptionsViewModel()
    init() {
        getData()
    }
    func getData() {
        let o1 = optionModel(optionName: "aaa")
        let o2 = optionModel(optionName: "bbb")
        let o3 = optionModel(optionName: "ccc")
        self.options.append(o1)
        self.options.append(o2)
        self.options.append(o3)
    }
    
    
    
}

class optionModel: Identifiable {
    let id = UUID().uuidString
    let optionName: String
    let isChecked: Bool
    
    init(optionName: String ) {
        self.optionName = optionName
        self.isChecked = false
    }
    
    
}


struct MainInfoView_AchievementSheet_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView(achieveSheetActive: true)
    }
}
