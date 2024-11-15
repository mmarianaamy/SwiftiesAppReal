//
//  textRecognition.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 11/11/24.
//

import SwiftUI
import Vision
import GoogleGenerativeAI
import PhotosUI
import Photos

struct TextRecognitionElectricidad: View {
    @State var loading : Bool = false
    
    //MARK: Photos
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImage: UIImage?
    
    
    //MARK: AI
    private let generativeModel = GenerativeModel(
        name: "gemini-1.5-flash",
        apiKey: "AIzaSyC1H8wcDSNVY-OdrIkWfGFUuwROo-NRVe8"
    )
    @State var response : GenerateContentResponse?
    
    func respond() async -> String {
        do{
            response = try await self.generativeModel.generateContent("Lo siguiente es un recibo de la CFE escaneado usando OCR. Dame el consumo de energía total. Unicamente regresa el valor del consumo, no lo acompañes de texto adicional. Por ejemplo, si el consumo es de 442 kWh, regresa 442. Si no se proporciona un recibo, si no contiene la info necesaria, o si no estas seguro de que puedas obtener el consumo de energía total, regresa 0 sin texto adicional: " + recognizedText)
            guard (response?.text != nil) else {
                throw MyError.runtimeError("some message")
                
            }
        }catch{
            print("nope")
        }
        return response?.text ?? ""
    }
    
    //MARK: OCR
    @State private var recognizedText: String = ""
    //private let image = UIImage(named: "example2")
    
    private func recognizeText(from image: UIImage?){
        guard let cgImage = image?.cgImage else { return }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: ", ")
            
            DispatchQueue.main.async {
                recognizedText = text
            }
        }
        //////Process the request
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            
            Text("Sube una foto de tu recibo digital")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            ShowInSafariButton(tipo: 1)
                .padding(.top, -5)
            Spacer()
            
            if loading {
                ProgressView()
            }
            if (response != nil){
                Text("Consumo de energía total del recibo: \n" + (response?.text ?? "") + "kWh")
                    .multilineTextAlignment(.leading)
                    .onAppear{
                    Task{
                        await respond()
                    }
                    loading = false
                }.padding()
            }
            
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .scaledToFit()
            }
            
            Spacer()
            
            Button{
                //MARK: To do -------
                ///Make it so that the value gets saved in the database
                ///Maybe instead of a button, a popup notification like that says "Is this value correct?" and has the option to confirm or retry
            }
            label:{
                Text("Confirmar")
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .tint(.yellow)
            
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 1, matching: .images) {
                Label("Seleccione una foto", systemImage: "photo")
            }
            .onChange(of: pickerItems) { _, newItems in
                if let item = newItems.first {
                    Task {
                        if let imageData = try? await item.loadTransferable(type: Data.self),
                           let loadedImage = UIImage(data: imageData) {
                            selectedImage = loadedImage
                            recognizeText(from: selectedImage)
                        }
                        Task{
                            await respond()
                        }
                    }
                    
                }
            }
            
            /*
             Divider()
             
             Text(recognizedText)
             .multilineTextAlignment(.center)
             .padding()
             .onAppear {
             recognizeText(from: image)
             }
             
             */
            
        }
        .padding()
    }
}

#Preview {
    TextRecognitionElectricidad()
}
