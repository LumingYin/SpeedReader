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

    @IBOutlet weak var readButton: NSButton!
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.titleVisibility = NSWindow.TitleVisibility.hidden;
        self.window?.styleMask.insert(.fullSizeContentView)
        shareButton.sendAction(on: .leftMouseDown)
    }

    @IBAction func historyClicked(_ sender: Any) {
        if let spvc = self.contentViewController as? SRSplitViewController {
            spvc.splitViewItems[0].isCollapsed = !spvc.splitViewItems[0].isCollapsed
        }
    }
    
    @IBAction func addClicked(_ sender: NSView) {
        if let vc = storyboard?.instantiateController(withIdentifier: "BlankDocument") as? NSViewController {
            self.contentViewController?.present(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.minY, behavior: .transient)
        }
    }
    
    @IBAction func readClicked(_ sender: Any) {
        openReaderWindow()
    }
    
    func openReaderWindow() {
        detailWindow = nil
        if let contentVC = self.contentViewController as? SRSplitViewController {
            if let textVC = contentVC.splitViewItems[1].viewController as? ArticleViewController {
                detailWindow = storyboard?.instantiateController(withIdentifier: "ReadDetailWindow") as? ReadDetailWindow
                if let readVC = detailWindow?.contentViewController as? ReadViewController {
                    if let article = textVC.article {
                        readVC.article = article
                        readVC.articlePreference = article.preference
                        if let speed = article.preference?.speed {
                            readVC.readingSliderValue = speed
                        } else {
                            readVC.readingSliderValue = 0.7
                        }
                        readVC.textToRead = textVC.contentTextView.string
                        if let font = article.preference?.font as? NSFont {
                            readVC.font = font
                        }
                        if let isDark = article.preference?.isDark {
                            readVC.enableDark = isDark
                        }
                    }
                }
                detailWindow?.showWindow(self)
            }
        }
    }

    
    @IBAction func shareClicked(_ sender: NSView) {
        var shareArray: [String] = []
        if let contentVC = self.contentViewController as? SRSplitViewController {
            if let textVC = contentVC.splitViewItems[1].viewController as? ArticleViewController {
                let article = textVC.contentTextView.string
                shareArray.append(article)
            }
        }
        let sharePicker = NSSharingServicePicker.init(items: shareArray)
        sharePicker.delegate = self
        sharePicker.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.minY)
        
    }

    @IBAction func preferenceSwapped(_ sender: NSSegmentedControl) {
        if let spvc = self.contentViewController as? SRSplitViewController {
            spvc.splitViewItems[2].isCollapsed = !spvc.splitViewItems[2].isCollapsed
            sender.setSelected(!spvc.splitViewItems[2].isCollapsed, forSegment: 0)
        }
    }
    
    @IBAction func historySwapped(_ sender: NSSegmentedControl) {
        if let spvc = self.contentViewController as? SRSplitViewController {
            spvc.splitViewItems[0].isCollapsed = !spvc.splitViewItems[0].isCollapsed
            sender.setSelected(!spvc.splitViewItems[0].isCollapsed, forSegment: 0)
        }
    }
}
