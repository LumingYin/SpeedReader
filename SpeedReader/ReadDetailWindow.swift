//
//  ReadDetailWindow.swift
//  SpeedReader
//
//  Created by Kay Yin on 7/3/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class ReadDetailWindow: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        self.window?.titleVisibility = NSWindow.TitleVisibility.hidden;
        self.window?.titlebarAppearsTransparent = true;
        self.window?.styleMask.insert(.fullSizeContentView)

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
