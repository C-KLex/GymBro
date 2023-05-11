//
//  MInfoView_AchiSheet.swift
//  GymBro
//
//  Created by user239615 on 5/8/23.
//

import SwiftUI

struct MInfoView_AchiSheet: View {
    
    @ObservedObject var achieveOptVM = AchievementOptionsViewModel.instance
    @State var isPopupActive: Bool = false
    @State var popupOption: OptionModel? = nil
    
    // MARK: BODY
    var body: some View {
        
        
        ZStack {
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
                    
                        ForEach(achieveOptVM.optionList, id: \.id) { optionModel in
                            
                            
                            
                            HStack {
                                
                                
                                self.checkIcon(optionModel: optionModel)
                                    .font(.title2)
                                    .onTapGesture {
                                        withAnimation(Animation.easeIn(duration: 0.1)) {
                                            achieveOptVM.checkOption(option: optionModel)
                                        }
                                    }
                                
                                
                                
                                HStack {
                                    Text(optionModel.optionName)
                                        .font(.title3)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "questionmark.circle")
                                        .font(.body)
                                        .foregroundColor(optionModel.isChecked ? Color.green : Color.gray)
                                        .onTapGesture {
                                            self.isPopupActive = true
                                            self.popupOption = optionModel
                                        }
                                    
                                }
                                
                                
                                
                                
                                    
                                Spacer()
           
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
            
            

            MInfoView_AchiSheet_QPopup(isPresented: self.$isPopupActive, option: self.$popupOption)
            
        }
        
    }
}





// MARK: COMPONENT

extension MInfoView_AchiSheet{
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
        let o1 = OptionModel(optionName: "Routine Complete")
        let o2 = OptionModel(optionName: "Training Volume")
        let o3 = OptionModel(optionName: "Goal Achieved")
        let o4 = OptionModel(optionName: "PR HIT")
        
        
        self.optionList.append(o1)
        self.optionList.append(o2)
        self.optionList.append(o3)
        self.optionList.append(o4)
        
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
    let introduction: String
    let isChecked: Bool
    
    init(optionName: String, introduction: String = "This is content This is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is contentThis is content", isChecked: Bool = false ) {
        self.optionName = optionName
        self.introduction = introduction
        self.isChecked = isChecked
    }
    
    
}


struct MainInfoView_AchievementSheet_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView(achieveSheetActive: true)
    }
}
