//
//  StepperView.swift
//  SwiftiesApp
//
//  Created by Alumno on 16/10/24.
//

import SwiftUI

struct StepperView: View {
    @State var quantity : Int = 0
    var limit : Int = 15
    var step : Int = 5
    var body: some View {
        HStack{
            TextField("Enter your score", value: $quantity, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .padding()
            Stepper("", value: $quantity, in: 0...limit, step: step)
        }
    }
}

#Preview {
    StepperView()
}
