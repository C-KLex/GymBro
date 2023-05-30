//
//  AchiCardMapping.swift
//  GymBro
//
//  Created by user239615 on 5/16/23.
//

import Foundation
import SwiftUI

/// To manage all the `AchievementCard` and to properly configure them.
///
/// - Warning: It needs to be updated everytime creating a new `AchievementModel` and it's corresponding `AchiCard`
class AchiCardRegister: ObservableObject {
    
    static let instance = AchiCardRegister()
    
    enum achiCardEnum: Int {
        case zero = 0
        case one = 1
        case two = 2
        case three = 3
    }
    
    let tagToView: [achiCardEnum: AnyView] = [
        .zero: AnyView(AchiCard_RoutineComplete()),
        .one: AnyView(AchiCard_TrainingVolume()),
        .two: AnyView(AchiCard_GoalAchieve()),
        .three: AnyView(AchiCard_PRHit()),
    ]
}
