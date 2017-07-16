//
//  SRPreferencesViewController.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRPreferencesViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    
    var speed: Float = 0.0
    var font: NSFont = NSFont.systemFont(ofSize: 12.0)
    
    var collapseSpeed: Bool = false
    var collapseFont: Bool = false
    var collapseAppearance: Bool = false
    var collapseLanguage: Bool = false
    var collapseWords: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do view setup here.
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var identifier = "SpeedCellView"
        switch row {
        case 0:
            identifier = "SpeedCellView"
        case 1:
            identifier = "FontCellView"
        case 2:
            identifier = "AppearanceCellView"
        case 3:
            identifier = "LanguageCellView"
        case 4:
            identifier = "WordsCellView"
        case 5:
            identifier = "ReadCellView"
        default:
            identifier = "SpeedCellView"
        }
        if let cell = tableView.make(withIdentifier: identifier, owner: self) as? SRGeneralPrefCellView {
            cell.delegate = self
            cell.configure()
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        switch row {
        case 0:
            return 79+10
        case 1:
            return 95+10
        case 2:
            return 105+10
        case 3:
            return 56+10
        case 4:
            return 56+10
        case 5:
            return 64
        default:
            return 95
        }
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
}
