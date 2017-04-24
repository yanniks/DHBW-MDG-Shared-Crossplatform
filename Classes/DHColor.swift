//
//  DHColor.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 24.04.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

#if os(macOS)
    import Cocoa

    typealias DHColor = CGColor
#elseif os(iOS)
    import UIKit

    typealias DHColor = UIColor
#endif
