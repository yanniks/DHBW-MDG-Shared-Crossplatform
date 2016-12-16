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
        var tableViewSetup : UITableView! = nil
        var navigationTitle: String? = nil {
            didSet {
                if let navigationTitle = navigationTitle {
                    navigationItem.title = navigationTitle
                } else {
                    navigationItem.title = ""
                }
            }
        }
        public func runTableViewSetup() {
            fatalError("Function must be overwritten")
        }
        override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dhTableView(tableView as! DHTableView, numberOfRowsInSection: section)
        }
        
        override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return dhTableView(tableView as! DHTableView, titleForHeaderInSection: section)
        }
        
        override public init(style: UITableViewStyle) {
            super.init(style: style)
            tableView = DHTableView()
            tableView.delegate = self
            tableView.dataSource = self
            //viewDidLoad()
        }
        
        override public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return dhTableView(tableView as! DHTableView, estimatedHeightForRowAt: indexPath)
        }
        
        override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            dhTableView(tableView as! DHTableView, didSelectRowAt: indexPath)
        }
        
        override public init(nibName: String?, bundle: Bundle?) {
            super.init(nibName: nil, bundle: nil)
            tableView = DHTableView(frame: tableView.frame, style: tableView.style)
            tableView.delegate = self
            tableView.dataSource = self
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override public func numberOfSections(in tableView: UITableView) -> Int {
            return numberOfSections(in: tableView as! DHTableView)
        }
        
        override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return dhTableView(tableView as! DHTableView, cellForRowAt: indexPath)
        }
    }
#elseif os(OSX)
    import Cocoa
    public class DHTableViewController: DHViewController, NSTableViewDataSource, NSTableViewDelegate {
        var tableViewSetup : NSTableView! = nil
        /*public var navigationTitle: String? = nil {
            didSet {
                /*if view.window == nil { return }
                if let navigationTitle = navigationTitle {
                    view.window?.title = navigationTitle
                } else {
                    view.window?.title = ""
                }*/
            }
        }*/
        public func runTableViewSetup() {
            fatalError("Function must be overwritten")
        }
        public override func viewDidLoad() {
            super.viewDidLoad()
        }
        public func numberOfRows(in tableView: NSTableView) -> Int {
            let secs = numberOfSections(in: tableView as! DHTableView)
            var count = 0
            for sec in 1...secs {
                count += dhTableView(tableView as! DHTableView, numberOfRowsInSection: sec - 1)
                if let _ = dhTableView(tableView as! DHTableView, titleForHeaderInSection: sec - 1) {
                    count += 1
                }
            }
            return count
        }
        override public func viewWillAppear() {
            super.viewWillAppear()
            runTableViewSetup()
            tableViewSetup.doubleAction = #selector(DHTableViewController.tvDoubleClicked)
            tableViewSetup.delegate = self
            tableViewSetup.dataSource = self
        }
        @objc private func tvDoubleClicked() {
            dhTableView(tableViewSetup as! DHTableView, didSelectRowAt: determineSection(tableView: tableViewSetup as! DHTableView, row: tableViewSetup.selectedRow))
        }
        public func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
            return determineSection(tableView: tableView as! DHTableView, row: row).row > -1
        }
        public func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
            let indexPath = determineSection(tableView: tableView as! DHTableView, row: row)
            if indexPath.row == -1 {
                return 20
            }
            return dhTableView(tableView as! DHTableView, estimatedHeightForRowAt: indexPath)
        }
        private func determineSection(tableView: DHTableView, row: Int) -> IndexPath {
            var rowsIncluded = 0
            var section = -1
            while (row + 1) > rowsIncluded  {
                section += 1
                rowsIncluded += dhTableView(tableView, numberOfRowsInSection: section)
                if let _ = dhTableView(tableView, titleForHeaderInSection: section) {
                    rowsIncluded += 1
                }
            }
            let finalRow = row - rowsIncluded + dhTableView(tableView, numberOfRowsInSection: section)
           return IndexPath(item: finalRow, section: section)
        }
        public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            let indexPath = determineSection(tableView: tableView as! DHTableView, row: row)
            if indexPath.row == -1 {
                return determineTitle(tableView: tableView as! DHTableView, section: indexPath.section)
            }
            if let originalCell = dhTableView(tableView as! DHTableView, originalCellForRowAt: indexPath) {
                return originalCell
            }
            let baseCell = dhTableView(tableView as! DHTableView, cellForRowAt: indexPath)
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
        private func determineTitle(tableView: DHTableView, section: Int) -> NSView? {
            guard let title = dhTableView(tableView, titleForHeaderInSection: section) else {
                return nil
            }
            let cell = NSTextField()
            cell.text = title
            cell.font = NSFont.boldSystemFont(ofSize: 14)
            cell.isBordered = false
            return cell
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
    func dhTableView(_ tableView: DHTableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    func dhTableView(_ tableView: DHTableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 17.0
    }
    func numberOfSections(in tableView: DHTableView) -> Int {
        return 1
    }
    func dhTableView(_ tableView: DHTableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func dhTableView(_ tableView: DHTableView, originalCellForRowAt indexPath: IndexPath) -> DHTableViewCell? {
        return nil
    }
    func dhTableView(_ tableView: DHTableView, cellForRowAt indexPath: IndexPath) -> DHTableViewCell {
        return DHTableViewCell(style: .default, reuseIdentifier: nil)
    }
    func dhTableView(_ tableView: DHTableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
