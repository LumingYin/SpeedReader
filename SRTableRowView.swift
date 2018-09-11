//
//  SRTableRowView.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRTableRowView: NSTableRowView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            let selectionRect = NSInsetRect(self.bounds, 0, 0)
            NSColor(calibratedWhite: 1, alpha: 0).setStroke()
            if #available(OSX 10.14, *) {
                if (NSApp.isActive) {
                    NSColor.selectedContentBackgroundColor.setFill()
                } else {
                    NSColor.unemphasizedSelectedContentBackgroundColor.setFill()
                }
            } else {
                NSColor(calibratedRed: 0.9882, green: 0.8941, blue: 0.607, alpha: 1).setFill()
            }
            let selectionPath = NSBezierPath.init(roundedRect: selectionRect, xRadius: 0, yRadius: 0)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }


    
}
