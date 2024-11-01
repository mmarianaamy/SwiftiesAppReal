//
//  StaticGradientView().swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import SwiftUI
import MulticolorGradient

struct StaticGradientViewBlue: View {
    @State private var animationAmount: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            MulticolorGradient {
                /*
                ColorStop(position: .top, color: Color(hex: 0xA98467))
                ColorStop(position: .bottom, color: Color(hex: 0xB5C99A))
                ColorStop(position: .top, color: Color(hex: 0xCFE1B9))
                ColorStop(position: .trailing, color: Color(hex: 0xE9F5DB))
                 */
                ColorStop(position: .top, color: Color(hex: 0x014F86))
                ColorStop(position: .trailing, color: Color(hex: 0x468FAF))
                ColorStop(position: .bottom, color: Color(hex: 0xE9F5DB))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    StaticGradientViewBlue()
}
