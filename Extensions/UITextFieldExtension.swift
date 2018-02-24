//
//  UITextFieldExtension.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 30.12.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

import UIKit

extension UITextField {
    func placeholderColor(_ color:UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: color])
    }
}
