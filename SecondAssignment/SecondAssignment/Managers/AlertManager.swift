//
//  AlertManager.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import UIKit

enum AlertManager {
    // MARK: - Nested Types
    struct ConfigurationModel {
        let title: String
        let subtitle: String
        let buttonText: String?
        let action: (() -> Void)?
        
        init(title: String,
             subtitle: String,
             buttonText: String? = nil,
             action: (() -> Void)? = nil) {
            self.title = title
            self.subtitle = subtitle
            self.buttonText = buttonText
            self.action = action
        }
    }
    
    // MARK: - Methods
    static func showAlert(with model: ConfigurationModel, from vc: UIViewController) {
        let alert = UIAlertController(title: model.title,
                                      message: model.subtitle,
                                      preferredStyle: .alert)
        if let buttonText = model.buttonText,
           let action = model.action {
            let button = UIAlertAction(title: buttonText, style: .default) { _ in
                action()
            }
            alert.addAction(button)
        } else {
            let button = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(button)
        }
        
        vc.present(alert, animated: true, completion: nil)
    }
}
