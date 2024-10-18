import SwiftUI

struct RecomendacionesView: View {
    var tipo: String  // nuevo parámetro para el tipo de recomendación

    var body: some View {
        NavigationView {
            VStack {

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        if tipo == "Hídrico" {
                            RecomendacionItemView(title: "Reduce el consumo de carne y lácteos")
                            RecomendacionItemView(title: "Toma duchas cortas (máximo 5 minutos)")
                            RecomendacionItemView(title: "Instala inodoros de descarga dual")
                            RecomendacionItemView(title: "Utiliza sistemas de riego por goteo")
                        } else if tipo == "Energético" {
                            RecomendacionItemView(title: "Apaga las luces al salir de una habitación")
                            RecomendacionItemView(title: "Usa electrodomésticos eficientes")
                            RecomendacionItemView(title: "Utiliza energía renovable")
                        } else if tipo == "Carbono" {
                            RecomendacionItemView(title: "Utiliza transporte público o bicicleta")
                            RecomendacionItemView(title: "Planta árboles para compensar emisiones")
                        } else if tipo == "Residuos" {
                            RecomendacionItemView(title: "Separa la basura en orgánica e inorgánica")
                            RecomendacionItemView(title: "Recicla papel, vidrio y plástico")
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct RecomendacionesView_Previews: PreviewProvider {
    static var previews: some View {
        RecomendacionesView(tipo: "Hídrico")
    }
}
