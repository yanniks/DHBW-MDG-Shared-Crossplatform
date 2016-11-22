//
//  DHTableView.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 08.11.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

#if os(iOS)
    import UIKit
    
    public class DHTableView: UITableView {
        
    }
#elseif os(macOS)
    import Cocoa
    
    public class DHTableView: NSTableView {
        
    }
#endif
