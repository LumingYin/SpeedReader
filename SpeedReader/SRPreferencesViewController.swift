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
    var article: Article?
    
//    var speed: Float = 0.1
//    var font: NSFont = NSFont.systemFont(ofSize: 24.0)
//    var enableDark: Bool = false
//    var increaseContrast = false
//    var reduceTransparency = false
//    var wordsPerRoll = 1
//    var contentLanguage = "en_US"
    
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
        if (row == 0) {
            return collapseSpeed ? 25: 79+10
        } else if (row == 1) {
            return collapseFont ? 25: 95+10
        } else if (row == 2) {
            return collapseAppearance ? 25: 105+10
        } else if (row == 3) {
            return collapseLanguage ? 25: 56+10
        } else if (row == 4) {
            return collapseWords ? 25: 56+10
        } else if (row == 5) {
            return 75
        } else {
            return 95
        }
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    func updateHeight() {
        tableView.reloadData()
    }
    
    func updateToReflectArticle() {
        if article != nil {
            tableView.reloadData()
        }
    }
}
