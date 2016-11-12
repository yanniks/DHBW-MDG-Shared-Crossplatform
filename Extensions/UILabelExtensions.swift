//
//  UILabelExtensions.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 11.11.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

import UIKit

extension UIFont {
    
    func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    var italic : UIFont {
        return withTraits(traits: .traitItalic)
    }
    
}
