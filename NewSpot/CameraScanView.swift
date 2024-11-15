//
//  CameraScanView.swift
//  prueba
//
//  Created by Alumno on 11/01/24.
//
import SwiftUI

struct CameraScanView: View {
    @EnvironmentObject var predictionStatus: PredictionStatus
    @StateObject var classifierViewModel = ClassifierViewModel()
    private(set) var labelData: Classification
    
    @State private var scan = "Unknown"
    
    var body: some View {
        let predictionLabel = predictionStatus.topLabel
        
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack (alignment: .center){
                VStack() {
                    ShowSignView(labelData: classifierViewModel.getPredictionData(label: predictionLabel))
                }
                
                VStack() {
                    LiveCameraRepresentable() {
                        predictionStatus.setLivePrediction(with: $0, label: $1, confidence: $2)
                    }
                }.padding(.leading)
                    .onAppear(perform: classifierViewModel.loadJSON)
                    .padding()
            }
        }
    }
}
        


#Preview {
    @Previewable @EnvironmentObject var predictionStatus: PredictionStatus
    @Previewable @StateObject var user = User() // Create an instance of User
    CameraScanView(labelData: Classification())
        .environmentObject(user)
        .environmentObject(predictionStatus)

    
    //return PreviewView()
}
 


