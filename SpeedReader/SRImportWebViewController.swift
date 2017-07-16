//
//  SRImportWebViewController.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRImportWebViewController: NSViewController {
    @IBOutlet weak var urlLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        getClipboardURL()
    }
    
    
    @IBAction func cancelPressed(_ sender: NSButton) {
        self.view.window?.sheetParent?.endSheet(self.view.window!, returnCode: NSModalResponseCancel)
    }
    
    @IBAction func importPressed(_ sender: NSButton) {
        self.view.window?.sheetParent?.endSheet(self.view.window!, returnCode: NSModalResponseOK)

    }
    
    func getClipboardURL() {
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    if type == "public.utf8-plain-text" {
                        if let url = item.string(forType: type) {
                            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                                urlLabel.stringValue = url
                            }
                        }
                    }
                }
            }
        }
    }
}
