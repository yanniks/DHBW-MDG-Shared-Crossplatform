//
//  DHErrorPresenter.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 18.11.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

import UIKit

public class DHErrorPresenter {
    public static func add(viewController: UIViewController, error: Error, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Fehler".localized, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Verstanden".localized, style: .default, handler: handler))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    public static func add(viewController: UIViewController, error: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Fehler".localized, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Verstanden".localized, style: .default, handler: handler))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
