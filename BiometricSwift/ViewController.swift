//
//  ViewController.swift
//  BiometricSwift
//
//  Created by Kevinho Morales on 4/3/24.
//

import UIKit
import LocalAuthentication

final class ViewController: UIViewController {
    
    @IBOutlet private weak var biometricResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func biometric() {
        let contexto = LAContext()
        var error: NSError?

        if contexto.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let descripción = "Autenticación requerida para acceder a la aplicación"
            contexto.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: descripción) { [weak self] (success, error) in
                guard let self else { return }
                DispatchQueue.main.async {
                    if success {
                        // Autenticación exitosa
                        self.biometricResultLabel.text = "ÉXITO EN LA BIOMETRÍA"
                        return
                    }
                    // Manejar el error
                    self.biometricResultLabel.text = "ERROR EN LA BIOMETRÍA"
                }
            }
        } else {
            // El dispositivo no es compatible con Face ID o Touch ID
            biometricResultLabel.text = "NO DISPONE DE BIOMETRÍA SU DISPOSITIVO"
        }
    }
    
    @IBAction private func biometricAction(_ sender: Any) {
        biometric()
    }
    

}

