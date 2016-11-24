//
//  DHTableViewCell.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 08.11.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

#if os(iOS)
    import UIKit
    
    public enum DHTableViewCellStyle { case `default`, value1, value2, subtitle }
    
    extension DHTableViewCellStyle {
        var uiStyle: UITableViewCellStyle {
            switch self {
            case .default:
                return .default
            case .value1:
                return .value1
            case .value2:
                return .value2
            case .subtitle:
                return .subtitle
            }
        }
    }
    
    public class DHTableViewCell: UITableViewCell {
        init(style: DHTableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style.uiStyle, reuseIdentifier: reuseIdentifier)
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
#elseif os(macOS)
    import Cocoa
    
    public enum DHTableViewCellStyle { case `default`, value1, value2, subtitle }
    
    public class DHTableViewCell: NSTableCellView {
        var cellTitle : String! = nil
        var cellDescription : String! = nil
        var cellImage : NSImage! = nil
        var customContents = [String : String]()
        
        init(style: DHTableViewCellStyle, reuseIdentifier: String?) {
            super.init(frame: NSRect(x: 0, y: 0, width: 50, height: 50))
        }
        
        required public init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
#endif
