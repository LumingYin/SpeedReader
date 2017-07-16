//
//  MainWindowController.swift
//  SpeedReader
//
//  Created by Kay Yin on 7/3/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSharingServicePickerDelegate {
    
    @IBOutlet weak var shareButton: NSButton!
    var detailWindow: ReadDetailWindow?
    var prefVC: SRPreferencesViewController?

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
        if let contentVC = self.contentViewController as? SRSplitViewController {
            if let prefVC = contentVC.splitViewItems[2].viewController as? SRPreferencesViewController {
                if let textVC = contentVC.splitViewItems[1].viewController as? ArticleViewController {
                    detailWindow = storyboard?.instantiateController(withIdentifier: "ReadDetailWindow") as? ReadDetailWindow
                    if let readVC = detailWindow?.contentViewController as? ReadViewController {
                        readVC.readingSliderValue = prefVC.speed
                        readVC.textToRead = textVC.contentTextView.string
                        readVC.font = prefVC.font
                    }
                    detailWindow?.showWindow(self)
                }
            }
        }
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
