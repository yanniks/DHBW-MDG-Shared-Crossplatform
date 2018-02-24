//
//  DHViewController.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 07.11.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

#if os(iOS)
    import UIKit
    
    public class DHViewController: UIViewController {
        @objc public var navigationTitle: String? = nil {
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
    public class DHViewController: NSViewController {
        public var navigationTitle: String? = nil {
            didSet {
                /*if let navigationTitle = navigationTitle {
                    view.window?.title = navigationTitle
                } else {
                    view.window?.title = ""
                }*/
            }
        }
    }
#endif
