//
//  MInfoView_AchiSheet_QPopup.swift
//  GymBro
//
//  Created by user239615 on 5/10/23.
//

import SwiftUI

/// In the `MInfoView_AchiSheet`, user can click the `quesitonMark` of each `Achievment` to learn the definition of the `Achievement`
struct MInfoView_AchiSheet_QPopup: View {
    
    
    // MARK: PROPERTY
    
    @Binding var isPresented: Bool
    
    /// The information for a specific `AchievementModel`
    @Binding var achievement: AchievementModel?
    
    
    // MARK: BODY
    
    var body: some View {
        if isPresented {
            VStack {
                
                // unwrap the optional var
                if let o = self.achievement {
                    VStack(spacing: 0) {
                        self.achievementTitle(achi: o)
                        self.sectionLine()
                        self.achievementIntroductionView(achi: o)
                        Spacer()
                        self.sectionLine()
                    }
                }
                
                self.okButton()
            }
            .frame(width: 350, height: 450)
            .background(Color("lightGray"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 5)
        }
    }
}


// MARK: COMPONENT

extension MInfoView_AchiSheet_QPopup {
    
    func okButton() -> some View {
        HStack {
            Text("OK")
                .font(.title2).foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(25)
                .padding(.vertical)
        }
        .onTapGesture {
            self.isPresented = false
        }
    }
    
    func sectionLine() -> some View {
        
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .frame(height: 1)
            .cornerRadius(10)
    }
        
    func achievementTitle(achi: AchievementModel) -> some View {
        VStack {
            Text(achi.achievementName)
                .font(.headline)
                .fontWeight(.medium)
                .padding()
                .frame(maxWidth: .infinity)
        }
    }
    
    func achievementIntroductionView(achi: AchievementModel) -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(achi.introduction)
                    .font(.body)
            }
            .padding()
            
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: PREVIEW

struct MInfoView_AchiSheet_QPopup_Previews: PreviewProvider {
    static var previews: some View {
        MInfoView_AchiSheet(isPopupActive: true)
    }
}
