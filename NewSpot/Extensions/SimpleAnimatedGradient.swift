//
//  SimpleAnimatedGradient.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import SwiftUI
import MulticolorGradient

struct SimpleAnimatedGradient: View {
    @State private var animationAmount: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            MulticolorGradient {
                ColorStop(position: .top, color: Color(hex: 0x168AAD))
                ColorStop(position: UnitPoint(x: 0.7, y: animationAmount), color: Color(hex: 0x52B69A))
                ColorStop(position: UnitPoint(x: animationAmount, y: 0.3), color: Color(hex: 0x76C893))
                ColorStop(position: UnitPoint(x: animationAmount, y: 0.6), color: Color(hex: 0xB5E48C))
            }
            .noise(64)
            .power(10.0)
            .edgesIgnoringSafeArea(.all).onAppear {
                withAnimation(.linear(duration: 3).repeatForever()) {
                    animationAmount = 1.0
                }
            }
        }
    }
}

#Preview {
    SimpleAnimatedGradient()
}
