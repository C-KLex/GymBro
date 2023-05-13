//
//  AchiCardRegister.swift
//  GymBro
//
//  Created by user239615 on 5/17/23.
//

import Foundation
import SwiftUI

/// Some general constant for the `AchievementCard`
class AchiCardProperty: ObservableObject {
    
    static let instance = AchiCardProperty()
    
    let cardWidth: CGFloat = 145.0
    let cardHeight: CGFloat = 195.0
    let cardCornerRadius: CGFloat = 20
    let shadowRadius: CGFloat = 5
    let shadowColor = Color.gray.opacity(0.3)
    let strokeColor = Color.gray.opacity(0.2)
    let strokeLineWidth: CGFloat = 1 
}
