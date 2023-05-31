//
//  MInfoView_AchiCard.swift
//  GymBro
//
//  Created by user239615 on 5/15/23.
//

import SwiftUI

/// Input an `AchievementModel`, and it iwll link to the proper card if needed.
///
/// Each `AchievementModel` has a property `tag`, which amis to be the key for the dictionary.
struct MInfoView_AchiCard: View {
    
    
    // MARK: PROPERTY
    
    /// Control which View to show.
    @ObservedObject var achiCardRegister = AchiCardRegister.instance
    
    /// Input Var
    @State var achievement: AchievementModel
    
    
    // MARK: BODY
    
    var body: some View {
        self.achievement.isChecked ? achiCardRegister.tagToView[achievement.tag] : nil
    }
}


// MARK: PREVIEW

struct MInfoView_AchiCard_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView()
    }
}
