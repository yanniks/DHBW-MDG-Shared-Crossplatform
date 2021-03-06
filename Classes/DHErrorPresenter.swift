//
//  DHErrorPresenter.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 18.11.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

#if os(iOS)
    
    import UIKit
    import PMAlertController
    
    public class DHErrorPresenter {
        public static func add(viewController: UIViewController, error: Error, handler: (() -> Void)? = nil) {
            let alert = PMAlertController(title: "Fehler".localized, description: error.localizedDescription, image: UIImage.fontAwesomeIcon(name: .exclamationTriangle, textColor: .red, size: CGSize(width: 256, height: 256)), style: .alert)
            alert.addAction(PMAlertAction(title: "Verstanden".localized, style: .default, action: handler))
            DispatchQueue.main.async {
                viewController.present(alert, animated: true, completion: nil)
            }
        }
        public static func add(viewController: UIViewController, error: String, handler: (() -> Void)? = nil) {
            let alert = PMAlertController(title: "Fehler".localized, description: error, image: UIImage.fontAwesomeIcon(name: .exclamationTriangle, textColor: .red, size: CGSize(width: 100, height: 100)), style: .alert)
            alert.addAction(PMAlertAction(title: "Verstanden".localized, style: .default, action: handler))
            DispatchQueue.main.async {
                viewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
#elseif os(macOS)
    import Cocoa
    
    public class DHErrorPresenter {
        public static func add(viewController: NSViewController, error: Error, handler: (() -> Void)? = nil) {
            let alert = NSAlert()
            alert.addButton(withTitle: "Verstanden".localized)
            alert.messageText = "Fehler".localized
            alert.informativeText = error.localizedDescription
            alert.alertStyle = .warning
            alert.runModal()
        }
        public static func add(viewController: NSViewController, error: String, handler: (() -> Void)? = nil) {
            let alert = NSAlert()
            alert.addButton(withTitle: "Verstanden".localized)
            alert.messageText = "Fehler".localized
            alert.informativeText = error
            alert.alertStyle = .warning
            alert.runModal()
        }
    }
#endif
