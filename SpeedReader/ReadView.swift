//
//  ReadView.swift
//  SpeedReader
//
//  Created by Blue on 4/29/19.
//  Copyright © 2019 Kay Yin. All rights reserved.
//

import Cocoa

class ReadView: NSView {
    var trackingArea: NSTrackingArea?
    weak var delegate: ReadViewController?

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if let area = trackingArea {
            self.removeTrackingArea(area)
        }
        trackingArea = NSTrackingArea.init(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
        if let area = trackingArea {
            self.addTrackingArea(area)
        }
    }

    override func mouseEntered(with event: NSEvent) {
        delegate?.enteredHandler(with: event)
    }

    override func mouseExited(with event: NSEvent) {
        delegate?.exitedHandler(with: event)
    }

}
