//
//  PrivacyPolicyView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 15/11/24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Política de Privacidad de New Spot")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top)

                        Text("Última actualización: 15/Nov/2024")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text("En New Spot, valoramos y respetamos tu privacidad. Esta Política de Privacidad describe cómo recopilamos, usamos, almacenamos y compartimos la información que proporcionas al utilizar nuestra aplicación. Al hacer uso de New Spot, estás aceptando las prácticas descritas en esta política. Si tienes alguna inquietud o no estás de acuerdo con algún aspecto de esta política, te sugerimos que revises nuestra información antes de continuar utilizando la App.")
                            .padding(.top)

                        Text("1. Información que recopilamos")
                            .font(.headline)

                        Text("New Spot recopila varios tipos de información relacionada con tus hábitos y actividades para calcular tus impactos ecológicos. La información que recopilamos incluye:")
                            .padding(.top)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("- Hábitos de consumo y actividad: El nombre del hábito, su frecuencia, cantidad, recurrencia y la fecha asociada.")
                            Text("- Compras realizadas: Información sobre productos comprados, incluyendo nombre del producto y cantidad.")
                            Text("- Distancias recorridas en automóvil: Utilizamos el GPS de tu dispositivo para rastrear las distancias que recorres en automóvil. Solo almacenamos la distancia recorrida y las emisiones de carbono generadas, pero no guardamos los datos de ubicación específicos.")
                            Text("- Información sobre amigos: Si decides agregar amigos, almacenamos esta relación.")
                        }

                        Text("2. Uso de la información")
                            .font(.headline)

                        Text("La información recopilada se utiliza con los siguientes fines:")
                            .padding(.top)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("- Análisis de impacto ecológico: Utilizamos tus datos de hábitos, compras, recibos y distancias recorridas para calcular tu impacto ambiental, incluidas las huellas de CO2 y agua.")
                            Text("- Interacción social: Permite a los usuarios agregar amigos y compartir su progreso en la App.")
                            Text("- Mejoras y personalización: Usamos los datos recopilados para mejorar la funcionalidad y personalización de la App, de modo que puedas obtener un análisis más preciso de tu impacto ecológico.")
                            Text("- Análisis por IA: La información que proporcionas sobre tus hábitos y fotos de recibos se envía a una IA para ser procesada y analizada.")
                        }

                        Text("3. Compartir y divulgación de datos")
                            .font(.headline)

                        Text("No compartimos tu información personal con terceros, excepto en los casos en que sea necesario para cumplir con las funciones de la App.")
                            .padding(.top)

                        Text("4. Seguridad de los datos")
                            .font(.headline)

                        Text("Nos comprometemos a proteger la información que recopilamos. Implementamos medidas de seguridad estándar para evitar el acceso no autorizado, la divulgación o la alteración de tu información personal. Sin embargo, no nos hacemos responsables por ninguna transmisión de datos a través de Internet que no pueda garantizarse como completamente segura, ni por cualquier brecha de seguridad que pueda resultar en información siendo comprometida.")
                            .padding(.top)

                        Text("5. Retención de datos")
                            .font(.headline)

                        Text("La información sobre tus hábitos, compras, y distancias recorridas se retiene para proporcionarte análisis precisos de tu impacto ecológico. Estos datos no se almacenan indefinidamente y pueden ser eliminados por ti en cualquier momento a través de la App.")
                            .padding(.top)

                        Text("6. Derechos del usuario")
                            .font(.headline)

                        Text("Como usuario de la App, tienes derecho a:")
                            .padding(.top)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("- Acceder a tu información: Puedes revisar y actualizar la información que has proporcionado en cualquier momento a través de la configuración de la App.")
                            Text("- Solicitar corrección o eliminiación de tus datos: Si crees que hay un error en la información que tenemos, o si deseas eliminar tu cuenta, puedes contactarnos explicando tu solicitud.")
                            
                        }

                        Text("7. Consentimiento")
                            .font(.headline)

                        Text("Al utilizar la App, aceptas de manera explícita los términos de esta Política de Privacidad. Al proporcionar tu información, nos das tu consentimiento para usarla según lo descrito en esta política. Si en algún momento decides que ya no deseas que procesemos tus datos de acuerdo con esta política, puedes eliminar tu cuenta o dejar de usar la App.")
                            .padding(.top)

                        Text("8. Cambios en la Política de Privacidad")
                            .font(.headline)

                        Text("Podemos actualizar esta política de privacidad de vez en cuando. Cuando lo hagamos, publicaremos la versión actualizada en la App y actualizaremos la fecha de la última actualización al principio de la política.")
                            .padding(.top)

                        Text("9. Contacto")
                            .font(.headline)

                        Text("Si tienes preguntas o inquietudes sobre esta Política de Privacidad o sobre cómo manejamos tus datos, puedes contactarnos en newspotsupport@proton.me.")
                            .padding(.top)
                    }
                    .padding()
                }

                Spacer()
            }
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
