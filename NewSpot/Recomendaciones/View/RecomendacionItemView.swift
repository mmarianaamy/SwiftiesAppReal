import SwiftUI

struct RecomendacionItemView: View {
    var titulo: String
    var descripcion: String
    @State private var isExpanded: Bool = false

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            Text(descripcion)
                .padding(.top, 5)
                .font(.body)
                .foregroundColor(.gray)
        } label: {
            HStack {
                Text(titulo)
                    .font(.headline)
                    .foregroundStyle(Color.primary)
                Spacer()
            }
        }
        .padding()
        .background(Color.primary.colorInvert())
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blueCustom, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct RecomendacionItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecomendacionItemView(titulo: "Reduce el consumo de carne y lácteos", descripcion: "descripcion :)")
    }
}
