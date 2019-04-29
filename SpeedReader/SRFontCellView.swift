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
    
    let allFontNames = NSFontManager.shared.availableFontFamilies
    let allFontSizes = [24, 36, 48, 64, 72, 96]

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
    
    @IBAction func collapse(_ sender: NSButton) {
        if (sender != disclosureTriangle) {
            if (disclosureTriangle.state == .on) {
                disclosureTriangle.state = .on
            } else {
                disclosureTriangle.state = .on
            }
        }

        if let delegate = delegate {
            delegate.collapseFont = !(delegate.collapseFont)
            delegate.updateHeight()
        }
    }
    
    override func configure() {
        if delegate?.article == nil {
            fontNamePopUp.isEnabled = false
            fontSizeComboBox.isEnabled = false
            fontSubFamilyPopUp.isEnabled = false
        } else {
            fontNamePopUp.isEnabled = true
            fontSizeComboBox.isEnabled = true
            fontSubFamilyPopUp.isEnabled = true
        }

        fontNamePopUp.removeAllItems()
        fontNamePopUp.addItem(withTitle: "System Font")
        fontNamePopUp.addItems(withTitles: allFontNames)
        
        updateSubFamily()
        fontSizeComboBox.removeAllItems()
        fontSizeComboBox.addItems(withObjectValues: allFontSizes)
        fontSizeComboBox.stringValue = "\(Int(self.delegate?.article?.preference?.fontSize ?? 24))"
        
        if let chosenFont = self.delegate?.article?.preference?.font as? NSFont {
//            Swift.print("\(chosenFont)")
            if let familyName = chosenFont.familyName {
                if familyName.contains(".SF") {
                    fontNamePopUp.selectItem(withTitle: "System Font")
                } else {
                    fontNamePopUp.selectItem(withTitle: familyName)
                }
                if let displayName = chosenFont.displayName {
                    if let range = displayName.range(of: familyName) {
                        let endPos = displayName.distance(from: displayName.startIndex, to: range.upperBound)
                        let offsetIndex = endPos.advanced(by: 1)
                        if displayName.count > endPos {
                            let index = displayName.index(displayName.startIndex, offsetBy: offsetIndex)
                            let variant = String(displayName[index...])
                            fontSubFamilyPopUp.selectItem(withTitle: variant)
                        }

                    }
                }
            }
            fontSizeComboBox.selectItem(withObjectValue: chosenFont.pointSize)
        }
    }
    
    func updateSubFamily() {
        fontSubFamilyPopUp.removeAllItems()
        if let selectedFamily = fontNamePopUp.titleOfSelectedItem {
            if let arrayofSubs = NSFontManager.shared.availableMembers(ofFontFamily: selectedFamily)  {
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
            let floatSize = CGFloat(truncating: n)
            if let desiredFont = NSFont.init(name: fontPostScriptArray[fontSubFamilyPopUp.indexOfSelectedItem], size: floatSize) {
                self.delegate?.article?.preference?.font = desiredFont
                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
            }
        }
    }

}
