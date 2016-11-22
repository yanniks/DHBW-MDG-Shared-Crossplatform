//
//  DHIndexPath.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 08.11.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//


#if os(macOS)
    import Cocoa
    
    public extension IndexPath {
        var row: Int {
            return item
        }
    }
#endif
