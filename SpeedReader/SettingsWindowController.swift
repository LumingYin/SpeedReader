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
//        self.window?.titlebarAppearsTransparent = true;
        self.window?.styleMask.insert(.fullSizeContentView)
    }

    @IBAction func historyClicked(_ sender: Any) {
        if let spvc = self.contentViewController as? SRSplitViewController {
            spvc.splitViewItems[0].isCollapsed = !spvc.splitViewItems[0].isCollapsed
        }
    }
    
    @IBAction func addClicked(_ sender: Any) {
    }
    
    @IBAction func readClicked(_ sender: Any) {
        
    }
    
    @IBAction func shareClicked(_ sender: Any) {
    }

    @IBAction func preferencesClicked(_ sender: Any) {
        if let spvc = self.contentViewController as? SRSplitViewController {
            spvc.splitViewItems[2].isCollapsed = !spvc.splitViewItems[2].isCollapsed
        }
    }
}
