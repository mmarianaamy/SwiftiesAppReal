import SwiftUI

struct HuellaCard: View {
    var title: String
    var value: Int
    var imageName: String  // Nombre de la imagen
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            Text("\(value)")
                .font(.title2)
            
            Text(title)
                .font(.subheadline)
        }
        .frame(width: 150, height: 150)
        .background(Color(.systemGray5))
        .cornerRadius(20)
    }
}
