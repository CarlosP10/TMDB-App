//
//  UIViewController+Extensions.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
}
