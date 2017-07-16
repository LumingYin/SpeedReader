//
//  SettingsWindowController.swift
//  SpeedReader
//
//  Created by Kay Yin on 7/3/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SettingsWindowController: NSWindowController, NSSharingServicePickerDelegate {
    
    @IBOutlet weak var shareButton: NSButton!
    var detailWindow: ReadDetailWindow?
    var speed: Float = 0.0
    
    var collapseSpeed: Bool = false
    

    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.titleVisibility = NSWindowTitleVisibility.hidden;
//        self.window?.titlebarAppearsTransparent = true;
        self.window?.styleMask.insert(.fullSizeContentView)
        shareButton.sendAction(on: .leftMouseDown)
    }

    @IBAction func historyClicked(_ sender: Any) {
        if let spvc = self.contentViewController as? SRSplitViewController {
            spvc.splitViewItems[0].isCollapsed = !spvc.splitViewItems[0].isCollapsed
        }
    }
    
    @IBAction func addClicked(_ sender: NSView) {
        let popover = NSPopover()
        if let vc = storyboard?.instantiateController(withIdentifier: "BlankDocument") as? NSViewController {
            popover.contentViewController = vc
        }
        popover.behavior = .transient
        popover.show(relativeTo: sender.bounds, of: sender, preferredEdge:NSRectEdge.minY)
    }
    
    @IBAction func readClicked(_ sender: Any) {
        openNewWindow()
    }
    
    func openNewWindow() {
        detailWindow = storyboard?.instantiateController(withIdentifier: "ReadDetailWindow") as? ReadDetailWindow
        if let readVC = detailWindow?.contentViewController as? ReadViewController {
            readVC.readingSliderValue = speed
//            readVC.textToRead = contentTextView.string
//            if let fontName = fontPopUp.selectedItem?.title {
//                readVC.fontName = fontName
//            }
        }
        detailWindow?.showWindow(self)
    }

    
    @IBAction func shareClicked(_ sender: NSView) {
        let sharePicker = NSSharingServicePicker.init(items: ["Demo"])
        sharePicker.delegate = self
        sharePicker.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.minY)
        
    }

    @IBAction func preferenceSwapped(_ sender: NSSegmentedControl) {
        if let spvc = self.contentViewController as? SRSplitViewController {
            spvc.splitViewItems[2].isCollapsed = !spvc.splitViewItems[2].isCollapsed
            sender.setSelected(!spvc.splitViewItems[2].isCollapsed, forSegment: 0)
        }
    }
    @IBAction func preferencesClicked(_ sender: Any) {
        if let spvc = self.contentViewController as? SRSplitViewController {
            spvc.splitViewItems[2].isCollapsed = !spvc.splitViewItems[2].isCollapsed
        }
    }
}
