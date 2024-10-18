import SwiftUI

struct GraphView: View {
    var imageName: String  // Nombre de la imagen pasada como argumento
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(imageName: "graph_image") // Imagen de prueba
    }
}
