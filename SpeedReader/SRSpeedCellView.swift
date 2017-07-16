//
//  SRSpeedCellView.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRSpeedCellView: SRGeneralPrefCellView {
    
    @IBOutlet weak var disclosureTriangle: NSButton!
    @IBOutlet weak var topLabel: NSButton!

    @IBOutlet weak var slider: NSSlider!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    @IBAction func speedChanged(_ sender: NSSlider) {
        delegate?.speed = sender.floatValue
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
            delegate.collapseSpeed = !(delegate.collapseSpeed)
            delegate.updateHeight()
        }
    }
    
    override func configure() {
        
    }

    
}
