//
//  DHViewController.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 07.11.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

#if os(iOS)
    import UIKit
    
    class DHViewController: UIViewController {
        var navigationTitle: String? = nil {
            didSet {
                if let navigationTitle = navigationTitle {
                    navigationItem.title = navigationTitle
                } else {
                    navigationItem.title = ""
                }
            }
        }
    }
#elseif os(OSX)
    import Cocoa
    class DHViewController: NSViewController {
        var navigationTitle: String? = nil {
            didSet {
                if let navigationTitle = navigationTitle {
                    view.window?.title = navigationTitle
                } else {
                    view.window?.title = ""
                }
            }
        }
    }
#endif
