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
    
    @State private var scan = "Cat"
    
    var body: some View {
        let predictionLabel = predictionStatus.topLabel
        GeometryReader { geo in
            ZStack(alignment: .center){
                Color(.background).ignoresSafeArea()
                
                VStack(alignment: .center){
                    
                    VStack() {
                        ShowSignView(labelData: classifierViewModel.getPredictionData(label: predictionLabel))
                    }
                    
                    VStack() {
                        LiveCameraRepresentable() {
                            predictionStatus.setLivePrediction(with: $0, label: $1, confidence: $2)
                        }
                        .frame(width: geo.size.width * 0.5)
                        
                        
                    }// VStack
                    .onAppear(perform: classifierViewModel.loadJSON)
                    
                        
                }//VStack
                
            }//ZStack
        } //Geo
    }
}

struct CameraScanViewPreviews: PreviewProvider {
    static var previews: some View {
        CameraScanView(labelData: Classification())
    }
}


 

