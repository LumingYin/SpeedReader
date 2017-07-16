//
//  SRLanguageCellView.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRLanguageCellView: SRGeneralPrefCellView {
    @IBOutlet weak var disclosureTriangle: NSButton!
    @IBOutlet weak var topLabel: NSButton!


    @IBOutlet weak var contentLanguagePopUp: NSPopUpButton!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    @IBAction func contentLanguageChanged(_ sender: NSPopUpButton) {
    }
    
    @IBAction func collapse(_ sender: Any) {
        if let delegate = delegate {
            delegate.collapseLanguage = !(delegate.collapseLanguage)
        }
    }

}
