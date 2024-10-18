//
//  RecomendacionesAIView.swift
//  SwiftiesApp
//
//  Created by Alumno on 18/10/24.
//

import SwiftUI
import GoogleGenerativeAI

enum MyError: Error {
    case runtimeError(String)
}

struct RecomendacionesAIView: View {
    let generativeModel = GenerativeModel(
        name: "gemini-1.5-flash",
        apiKey: "AIzaSyC1H8wcDSNVY-OdrIkWfGFUuwROo-NRVe8"
      )
      

    @State var response : GenerateContentResponse?
    @State var pregunta : String = ""
    @State var markdownText : LocalizedStringKey = ""
    @State var loading : Bool = false
    
    func respond() async -> String {
        do{
            response = try await self.generativeModel.generateContent("Respondeme en 10 lineas. Puedes incluir formato markdown para bold y italics." + pregunta)
            guard (response?.text != nil) else {
                throw MyError.runtimeError("some message")
                
            }
            markdownText = LocalizedStringKey(response?.text ?? "nada")
        }catch{
            print("nope")
        }
        return response?.text ?? ""
    }
    
    var body: some View {
        VStack{
            if loading {
                ProgressView()
            }
            if (response != nil){
                Text(markdownText).onAppear{
                    Task{
                        await respond()
                    }
                    loading = false
                }.padding()
            }
            
            HStack{
                TextField("Que deseas preguntar?", text: $pregunta, axis: .vertical).padding().border(Color.button).padding().keyboardType(.default)
                Button{
                    loading = true
                    Task{
                        await respond()
                    }
                }label:{
                    Image(systemName: "paperplane.fill")
                }.padding()
            }
            
        }
    }
}

#Preview {
    RecomendacionesAIView()
}
