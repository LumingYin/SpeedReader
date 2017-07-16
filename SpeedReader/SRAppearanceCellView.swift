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
    @IBOutlet weak var increaseContrastBtn: NSButton!
    @IBOutlet weak var reduceTransparencyBtn: NSButton!

    @IBOutlet weak var lightDarkToggle: NSSegmentedControl!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func configure() {
        if let isDark = self.delegate?.article?.preference?.isDark {
            if isDark {
                lightDarkToggle.selectSegment(withTag: 1)
            } else {
                lightDarkToggle.selectSegment(withTag: 0)
            }
        }
        
        if let increaseContrast = self.delegate?.article?.preference?.increaseContrast {
            if increaseContrast {
                increaseContrastBtn.state = NSOnState
            } else {
                increaseContrastBtn.state = NSOffState
            }
        }

        if let reduceTransparency = self.delegate?.article?.preference?.reduceTransparency {
            if reduceTransparency {
                reduceTransparencyBtn.state = NSOnState
            } else {
                reduceTransparencyBtn.state = NSOffState
            }
        }

    }
    
    @IBAction func lightDarkChanged(_ sender: NSSegmentedControl) {
        if sender.selectedSegment == 0 {
            self.delegate?.article?.preference?.isDark = false
        } else {
            self.delegate?.article?.preference?.isDark = true
        }
        (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
    }
    
    @IBAction func increaseContrastChanged(_ sender: NSButton) {
        if sender.state == NSOnState {
            self.delegate?.article?.preference?.increaseContrast = true
        } else {
            self.delegate?.article?.preference?.increaseContrast = false
        }
        (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
    }
    
    @IBAction func reduceTransparencyChanged(_ sender: NSButton) {
        if sender.state == NSOnState {
            self.delegate?.article?.preference?.reduceTransparency = true
        } else {
            self.delegate?.article?.preference?.reduceTransparency = true
        }
        (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
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
