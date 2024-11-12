//
//  ShowInSafari.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 12/11/24.
//

import SwiftUI
import SafariServices

struct ShowInSafariButton: View {
    
    private let tipo: Int
    private let search: URL?
    
    init(tipo: Int) {
            self.tipo = tipo
            switch tipo {
            case 1:
                self.search = URL(string: "https://app.cfe.mx/aplicaciones/CCFE/SolicitudesCFE/Solicitudes/ConsultaTuReciboLuzGmx")
            case 2:
                self.search = URL(string: "https://app.cfe.mx/aplicaciones/CCFE/SolicitudesCFE/Solicitudes/ConsultaTuReciboLuzGmx")
            case 3:
                self.search = URL(string: "https://app.cfe.mx/aplicaciones/CCFE/SolicitudesCFE/Solicitudes/ConsultaTuReciboLuzGmx")
            default:
                self.search = nil
            }
        }
    
    var body: some View {
        Button {
            let vc: UIViewController
            if search == nil {
                // google
                let googleSearchString = "decarga+recibo+cfe"
                vc = SFSafariViewController(url: URL(string: "https://www.google.com/search?q=\(googleSearchString)")!)
            } else {
                vc = SFSafariViewController(url: search!)
            }
            UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
        } label: {
            HStack {
                Text ("Consulta y descarga tu recibo")
                //Image (systemName: "arrow.forward")
            }
            .padding ()
            .underline()
            .foregroundStyle(Color.blue)
            
        }
        .buttonStyle(.borderless)
        
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive}
            .first?.keyWindow
    }
}
