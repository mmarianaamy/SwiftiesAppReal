//
//  LoginTest.swift
//  LoginTest
//
//  Created by Carolina De los Santos Reséndiz on 01/12/24.
//

import SwiftUI
import XCTest
@testable import New_Spot

// Clase Espía para capturar cambios de estado
class LoginPageSpy {
    private var capturedAlerts: [LoginPage.AlertType] = []
    private(set) var isLoggedIn: Bool = false

    func captureAlert(alert: LoginPage.AlertType?) {
        if let alert = alert {
            capturedAlerts.append(alert)
        }
    }

    func captureLoggedInState(isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
    }

    var lastAlert: LoginPage.AlertType? {
        return capturedAlerts.last
    }
}

final class LoginTest: XCTestCase {

    override func setUpWithError() throws {
        // Configuración inicial antes de cada prueba
    }

    override func tearDownWithError() throws {
        // Limpieza después de cada prueba
    }

    func testEmailAndPasswordInput() {
        let state = LoginPageState()
        state.email = "test@example.com"
        state.password = "password123"
        
        // Validar
        XCTAssertEqual(state.email, "test@example.com")
        XCTAssertEqual(state.password, "password123")
    }
    
    func testInvalidLoginDoesNotTriggerNavigation() async {
        let state = LoginPageState()
        var logged = false

        let loggedBinding = Binding<Bool>(
            get: { logged },
            set: { logged = $0 }
        )

        // Crear instancia de LoginPage
        var loginPage = LoginPage(state: state, logged: loggedBinding)

        // Simular inicio de sesión con credenciales inválidas
        await loginPage.signInWithEmail(email: "invalid@example.com", password: "wrongpassword")

        // Validar que la navegación no fue activada
        XCTAssertFalse(loggedBinding.wrappedValue, "La navegación no debería activarse para credenciales inválidas.")
    }
}
