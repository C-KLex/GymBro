//
//  MInfoView_AchiSheet.swift
//  GymBro
//
//  Created by user239615 on 5/8/23.
//

import SwiftUI

/// Sheet for picking what training highlights the user want to see
struct MInfoView_AchiSheet: View {
    
    
    // MARK: PROPERTY

    @ObservedObject var achieveOptVM = AchievementSheetViewModel.instance
    
    /// Question Mark Information Popup
    @State var isPopupActive: Bool = false
    @State var popupAchi: AchievementModel? = nil
    
    // MARK: BODY
    var body: some View {
        ZStack {
            
            // normal sheet view
            self.achiSheet()
            
            // If it triggers the quesiton mark popup
            MInfoView_AchiSheet_QPopup(isPresented: self.$isPopupActive, achievement: self.$popupAchi)
        }
    }
}


// MARK: COMPONENT

extension MInfoView_AchiSheet{
    
    /// The sheet itself when the quiestion mark information popup is not triggered.
    ///
    /// When the question mark is tapped, this sheet wil be blurred and the quesiton popup will be the frontest layer.
    func achiSheet() -> some View {
        
        VStack(alignment: .center, spacing: 20) {
            
            DismissButtonView()
            HStack {
                Text("What to Show 👀")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                    ForEach(achieveOptVM.achievementList, id: \.id) { optionModel in
                        
                        HStack {
                            
                            HStack {
                                self.checkIcon(optionModel: optionModel)
                                    .font(.title2)
                    
                                Text(optionModel.achievementName)
                                    .font(.title3)
                            }
                            .onTapGesture {
                                withAnimation(Animation.easeIn(duration: 0.1)) {
                                    achieveOptVM.checkOption(option: optionModel)
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "questionmark.circle")
                                .font(.body)
                                .foregroundColor(optionModel.isChecked ? Color.green : Color.gray)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        self.isPopupActive = true
                                    }
                                    self.popupAchi = optionModel
                                }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(optionModel.isChecked ? Color.green.opacity(0.2) : Color.gray.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(optionModel.isChecked ? Color.green.opacity(0.2) : Color.gray.opacity(0.2), lineWidth: 2)
                                )
                        )
                    }
            }
            .frame(width: 330)
            Spacer()
        }
        .blur(radius: self.isPopupActive ? 20 : 0)
    }
    
    @ViewBuilder
    /// Two different state of the check mark.
    func checkIcon(optionModel: AchievementModel) -> some View {
        if optionModel.isChecked {
            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
        } else {
            Image(systemName: "circle").foregroundColor(.gray)
        }
    }
}


// MARK: VIEWMODEL

/// Mock View Model
class AchievementSheetViewModel: ObservableObject {
    
    @Published var achievementList: [AchievementModel] = []
    
    static let instance = AchievementSheetViewModel()
    
    init() {
        getData()
    }
    
    func getData() -> () {
        let o1 = AchievementModel(achievementName: "Routine Complete", isChecked: true, tag: .zero)
        let o2 = AchievementModel(achievementName: "Training Volume", isChecked: false, tag: .one)
        let o3 = AchievementModel(achievementName: "Goal Achieved", isChecked: true, tag: .two)
        let o4 = AchievementModel(achievementName: "PR HIT", isChecked: false, tag: .three)
        self.achievementList.append(o1)
        self.achievementList.append(o2)
        self.achievementList.append(o3)
        self.achievementList.append(o4)
    }
    
    /// User checks the check mark and change the state of a `AchievementModel`
    func checkOption(option: AchievementModel) -> () {
        guard let index = self.achievementList.firstIndex(where: { $0.id == option.id }) else { return }
        let updatedOption = AchievementModel(achievementName: option.achievementName, isChecked: !option.isChecked, tag: option.tag)
        self.achievementList.remove(at: index)
        self.achievementList.insert(updatedOption, at: index)
    }
}

/// Mock Model
class AchievementModel: Identifiable {
    
    let id = UUID().uuidString
    let achievementName: String
    let introduction: String
    let isChecked: Bool
    let tag: AchiCardRegister.achiCardEnum
    
    init(achievementName: String, introduction: String = "This is content This is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is content This is content This is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is content", isChecked: Bool = false, tag: AchiCardRegister.achiCardEnum) {
        
        self.achievementName = achievementName
        self.introduction = introduction
        self.isChecked = isChecked
        self.tag = tag
        
    }
}


// MARK: PREVIEW

struct MainInfoView_AchievementSheet_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView(achieveSheetActive: true)
    }
}
