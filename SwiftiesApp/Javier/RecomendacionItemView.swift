import SwiftUI

struct RecomendacionItemView: View {
    var title: String
    @State private var isExpanded: Bool = false

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            Text("Cada pequeño cambio contribuye a reducir la huella hídrica y promueve un uso más sostenible y consciente del agua.")
                .padding(.top, 5)
                .font(.body)
                .foregroundColor(.gray)
        } label: {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct RecomendacionItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecomendacionItemView(title: "Reduce el consumo de carne y lácteos")
    }
}
