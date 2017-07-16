//
//  SRFontCellView.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRFontCellView: SRGeneralPrefCellView {
    @IBOutlet weak var disclosureTriangle: NSButton!
    @IBOutlet weak var topLabel: NSButton!
    
    @IBOutlet weak var fontNamePopUp: NSPopUpButton!
    @IBOutlet weak var fontSubFamilyPopUp: NSPopUpButton!
    @IBOutlet weak var fontSizeComboBox: NSComboBox!
    var fontPostScriptArray: [String] = []
    
    let allFontNames = NSFontManager.shared().availableFontFamilies
    let allFontSizes = [9, 10, 11, 12, 13, 14, 18, 24, 36, 48, 64, 72, 96]

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    @IBAction func fontNameChanged(_ sender: NSPopUpButton) {
        updateSubFamily()
        updateFontInDelegate()
    }
    
    @IBAction func fontSubFamilyChanged(_ sender: NSPopUpButton) {
        updateFontInDelegate()
    }
    
    @IBAction func fontSizeChanged(_ sender: NSComboBox) {
        updateFontInDelegate()
    }
    
    @IBAction func collapse(_ sender: Any) {
        if let delegate = delegate {
            delegate.collapseFont = !(delegate.collapseFont)
        }
    }
    
    override func configure() {
        fontNamePopUp.removeAllItems()
        fontNamePopUp.addItem(withTitle: "System Font")
        fontNamePopUp.addItems(withTitles: allFontNames)
        
        updateSubFamily()
        fontSizeComboBox.removeAllItems()
        fontSizeComboBox.addItems(withObjectValues: allFontSizes)
        fontSizeComboBox.selectItem(at: 5)
    }
    
    func updateSubFamily() {
        fontSubFamilyPopUp.removeAllItems()
        if let selectedFamily = fontNamePopUp.titleOfSelectedItem {
            if let arrayofSubs = NSFontManager.shared().availableMembers(ofFontFamily: selectedFamily)  {
                var resultingSub:[String] = []
                fontPostScriptArray = []
                for i in 0..<arrayofSubs.count {
                    if let nameOfSubFamily = arrayofSubs[i][1] as? String {
                        resultingSub.append(nameOfSubFamily)
                    }
                    if let nameOfPostScript = arrayofSubs[i][0] as? String {
                        fontPostScriptArray.append(nameOfPostScript)
                    }
                }
                fontSubFamilyPopUp.addItems(withTitles: resultingSub)
            }
        }
    }
    
    func updateFontInDelegate() {
        if let n = NumberFormatter().number(from: fontSizeComboBox.stringValue) {
            let floatSize = CGFloat(n)
            if let desiredFont = NSFont.init(name: fontPostScriptArray[fontSubFamilyPopUp.indexOfSelectedItem], size: floatSize) {
                self.delegate?.font = desiredFont
            }
        }
    }

}
