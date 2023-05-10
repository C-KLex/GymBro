//
//  PulseProgressBar.swift
//  GymBro
//
//  Created by user239615 on 5/9/23.
//

import SwiftUI

struct PulseProgressBar: View {
    
    @State var progress: Double
    @Binding var pulseEffect: Bool
    @Binding var pulseAnimationIsActive: Bool
    let pulseAnimation = Animation.easeIn(duration: 1).repeatForever(autoreverses: false)
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
                    self.pulseAnimationIsActive = true
                }
                .onChange(of: pulseAnimationIsActive) { isActive in
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

struct PulseProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoView()
    }
}
