//
//  StaticGradientView().swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import SwiftUI
import MulticolorGradient

struct StaticGradientView: View {
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
                ColorStop(position: .top, color: Color(hex: 0xB5C99A))
                ColorStop(position: .trailing, color: Color(hex: 0xD9ED92))
                ColorStop(position: .bottom, color: Color(hex: 0xE9F5DB))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}


#Preview {
    StaticGradientView()
}
