//
//  UIAlertController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/25.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, buttonTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            //completion?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
