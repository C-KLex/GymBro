//
//  PulseProgressBar.swift
//  GymBro
//
//  Created by user239615 on 5/9/23.
//

import SwiftUI

/// Progress Bar with Pulsing effect
///
/// Need to input the progress rate and two binding variable for animation's usage
struct PulseProgressBar: View {
    
    
    // MARK: PROPERTY
    
    /// The progress rate
    @State var progress: Double
    
    /// The effect itself, turn on and turn off to create animation
    @Binding var pulseEffect: Bool
    
    /// To control the overall animation, this is for reset the animation to prevent multiple `pulseEffect` on one object
    @Binding var pulseAnimationIsActive: Bool
    
    /// The animation alias
    let pulseAnimation = Animation.easeIn(duration: 1).repeatForever(autoreverses: false)
    
    
    // MARK: BODY
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 10)
                        .opacity(0.3)
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                    Rectangle()
                        .frame(width: min(CGFloat(self.pulseEffect ? progress : progress + 0.005) * geometry.size.width, geometry.size.width), height: 10)
                        .foregroundColor(Color.blue)
                        .opacity(self.pulseEffect ? 1 : 0.8)
                        .brightness(self.pulseEffect ? -0.005 : 0.005)
                        .cornerRadius(20)
                }
                .onAppear {
                    // Start animation when the appear
                    self.pulseAnimationIsActive = true
                }
                .onChange(of: pulseAnimationIsActive) { isActive in
                    
                    // This block is in charge for any reason which needs to reset the animation, such as add more progress bar
                    if !isActive {
                        withAnimation(.linear(duration: 0)) {
                            self.pulseEffect = false
                        }
                    } else {
                        withAnimation(pulseAnimation) {
                            self.pulseEffect = true
                        }
                    }
                }
            }
        }
    }
}


// MARK: PREVIEW

struct PulseProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView()
    }
}
