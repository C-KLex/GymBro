//
//  MainInfoView_AchievementSheet.swift
//  GymBro
//
//  Created by user239615 on 5/8/23.
//

import SwiftUI

struct MainInfoView_AchievementSheet: View {
    
    @ObservedObject var achieveOptVM = AchievementOptionsViewModel.instance
    
    // MARK: BODY
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
                ForEach(achieveOptVM.optionList, id: \.id) { optionModel in
                    HStack {
                        
                        
                        self.checkIcon(optionModel: optionModel)
                            .font(.title2)
                            .onTapGesture {
                                achieveOptVM.checkOption(option: optionModel)
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


// MARK: COMPONENT

extension MainInfoView_AchievementSheet{
    func checkIcon(optionModel: OptionModel) -> some View {
        if optionModel.isChecked {
            return Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
        } else {
            return Image(systemName: "circle").foregroundColor(.gray)
        }
    }
}


// MARK: VIEWMODEL

class AchievementOptionsViewModel: ObservableObject {
    @Published var optionList: [OptionModel] = []
    static let instance = AchievementOptionsViewModel()
    init() {
        getData()
    }
    func getData() {
        let o1 = OptionModel(optionName: "aaa")
        let o2 = OptionModel(optionName: "bbb")
        let o3 = OptionModel(optionName: "ccc")
        self.optionList.append(o1)
        self.optionList.append(o2)
        self.optionList.append(o3)
    }
    
    func checkOption(option: OptionModel) {
        guard let index = self.optionList.firstIndex(where: { $0.id == option.id }) else { return }
        let updatedOption = OptionModel(optionName: option.optionName, isChecked: !option.isChecked)
        self.optionList.remove(at: index)
        self.optionList.insert(updatedOption, at: index)
    }
    
    
}

class OptionModel: Identifiable {
    let id = UUID().uuidString
    let optionName: String
    let isChecked: Bool
    
    init(optionName: String, isChecked: Bool = false ) {
        self.optionName = optionName
        self.isChecked = isChecked
    }
    
    
}


struct MainInfoView_AchievementSheet_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView(achieveSheetActive: true)
    }
}
