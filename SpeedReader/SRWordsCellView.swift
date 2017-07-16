//
//  SRWordsCellView.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRWordsCellView: SRGeneralPrefCellView {
    @IBOutlet weak var disclosureTriangle: NSButton!
    @IBOutlet weak var topLabel: NSButton!


    @IBOutlet weak var wordsPerRoll: NSSegmentedControl!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    @IBAction func wordsPerRollChanged(_ sender: NSSegmentedControl) {
    }
    
    @IBAction func collapse(_ sender: NSButton) {
        if (sender != disclosureTriangle) {
            if (disclosureTriangle.state == NSOnState) {
                disclosureTriangle.state = NSOffState
            } else {
                disclosureTriangle.state = NSOnState
            }
        }
        if let delegate = delegate {
            delegate.collapseWords = !(delegate.collapseWords)
            delegate.updateHeight()
        }
    }
}
