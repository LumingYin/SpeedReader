//
//  SettingsWindowController.swift
//  SpeedReader
//
//  Created by Kay Yin on 7/3/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SettingsWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.titleVisibility = NSWindowTitleVisibility.hidden;
        self.window?.titlebarAppearsTransparent = true;
        self.window?.styleMask.insert(.fullSizeContentView)
    }

}
