//
//  DHTableViewController.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 08.11.16.
//  Copyright © 2016 Yannik Ehlert. All rights reserved.
//

#if os(iOS)
    import UIKit
    
    public class DHTableViewController: UITableViewController {
        var navigationTitle: String? = nil {
            didSet {
                if let navigationTitle = navigationTitle {
                    navigationItem.title = navigationTitle
                } else {
                    navigationItem.title = ""
                }
            }
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dhTableView(tableView as! DHTableView, numberOfRowsInSection: 0)
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return dhTableView(tableView as! DHTableView, cellForRowAt: indexPath)
        }
    }
#elseif os(OSX)
    import Cocoa
    public class DHTableViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
        var tableViewSetup : NSTableView! = nil
        var navigationTitle: String? = nil {
            didSet {
                /*if view.window == nil { return }
                if let navigationTitle = navigationTitle {
                    view.window?.title = navigationTitle
                } else {
                    view.window?.title = ""
                }*/
            }
        }
        public func runTableViewSetup() {
            fatalError("Function must be overwritten")
        }
        public override func viewDidLoad() {
            super.viewDidLoad()
        }
        public func numberOfRows(in tableView: NSTableView) -> Int {
            return dhTableView(tableView as! DHTableView, numberOfRowsInSection: 0)
        }
        override public func viewWillAppear() {
            super.viewWillAppear()
            runTableViewSetup()
            tableViewSetup.delegate = self
            tableViewSetup.dataSource = self
        }
        public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            let baseCell = dhTableView(tableView as! DHTableView, cellForRowAt: IndexPath(item: row, section: 0))
            if baseCell.cellTitle == nil {
                return nil
            }
            var cellIdentifier : String?
            var textLabel : String?
            var imageView : NSImage?
            if tableViewSetup.tableColumns[0] == tableColumn {
                cellIdentifier = "NameCellID"
                textLabel = baseCell.cellTitle
                if baseCell.cellImage != nil {
                    imageView = baseCell.cellImage
                }
            } else if tableViewSetup.tableColumns[1] == tableColumn {
                cellIdentifier = "NameDescriptionID"
                textLabel = baseCell.cellDescription
            } else {
                if baseCell.customContents.count > (tableViewSetup.tableColumns.count - 2) {
                    cellIdentifier = Array(baseCell.customContents.keys)[tableViewSetup.tableColumns.count - 3]
                    textLabel = baseCell.customContents[cellIdentifier!]
                }
            }
            guard let fCellIdentifier = cellIdentifier, let fTextLabel = textLabel else {
                return nil
            }
            if let cell = tableViewSetup.make(withIdentifier: fCellIdentifier, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = fTextLabel
                cell.imageView?.image = imageView ?? nil
                return cell
            }
            return nil
        }
        public func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
            dhTableView(tableView as! DHTableView, didSelectRowAt: IndexPath(item: row, section: 0))
            return true
        }
        override init(nibName: String?, bundle: Bundle?) {
            super.init(nibName: nibName, bundle: bundle)!
            viewDidLoad()
        }
        required public init?(coder: NSCoder) {
            super.init(coder: coder)
            viewDidLoad()
        }
    }
#endif

public extension DHTableViewController {
    func dhTableView(_ tableView: DHTableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func dhTableView(_ tableView: DHTableView, cellForRowAt indexPath: IndexPath) -> DHTableViewCell {
        return DHTableViewCell(style: .default, reuseIdentifier: nil)
    }
    func dhTableView(_ tableView: DHTableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
