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

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    @IBAction func fontNameChanged(_ sender: NSPopUpButton) {
    }
    
    @IBAction func fontSubFamilyChanged(_ sender: NSPopUpButton) {
    }
    
    @IBAction func fontSizeChanged(_ sender: NSComboBox) {
    }
    
    @IBAction func collapse(_ sender: Any) {
        if let delegate = delegate {
            delegate.collapseFont = !(delegate.collapseFont)
        }
    }

}
