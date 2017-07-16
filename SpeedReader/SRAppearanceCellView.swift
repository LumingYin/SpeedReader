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
    }
    
    @IBAction func increaseContrastChanged(_ sender: NSButton) {
    }
    
    @IBAction func reduceTransparencyChanged(_ sender: NSButton) {
    }
    
    @IBAction func collapse(_ sender: Any) {
        if let delegate = delegate {
            delegate.collapseAppearance = !(delegate.collapseAppearance)
        }
    }

}
