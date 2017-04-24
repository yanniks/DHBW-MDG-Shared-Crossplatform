//
//  DHAliases.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 24.04.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

#if os(macOS)
    import Cocoa
    
    public typealias DHLabel = NSTextField
#elseif os(iOS)
    import UIKit
    
    public typealias DHLabel = UILabel
#endif
