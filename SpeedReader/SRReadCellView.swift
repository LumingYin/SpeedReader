//
//  SRReadCellView.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRReadCellView: SRGeneralPrefCellView {

    @IBOutlet weak var speedReadButton: NSButton!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func configure() {
        if (speedReadButton != nil) {
            if delegate?.article == nil {
                speedReadButton.isEnabled = false
            } else {
                speedReadButton.isEnabled = true
            }
        }
    }
    
    @IBAction func readInlineClicked(_ sender: Any) {
    }
    
}
