//
//  SRAppearanceCellView.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRAppearanceCellView: SRGeneralPrefCellView {
    @IBOutlet weak var disclosureTriangle: NSButton!
    @IBOutlet weak var topLabel: NSButton!


    @IBOutlet weak var lightDarkToggle: NSSegmentedControl!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    @IBAction func lightDarkChanged(_ sender: NSSegmentedControl) {
        if sender.selectedSegment == 0 {
            delegate?.enableDark = false
        } else {
            delegate?.enableDark = true
        }
    }
    
    @IBAction func increaseContrastChanged(_ sender: NSButton) {
        if sender.state == NSOnState {
            delegate?.increaseContrast = true
        } else {
            delegate?.increaseContrast = false
        }
    }
    
    @IBAction func reduceTransparencyChanged(_ sender: NSButton) {
        if sender.state == NSOnState {
            delegate?.reduceTransparency = true
        } else {
            delegate?.reduceTransparency = false
        }
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
            delegate.collapseAppearance = !(delegate.collapseAppearance)
            delegate.updateHeight()
        }
    }

}
