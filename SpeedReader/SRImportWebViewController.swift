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
        // Do view setup here.
    }
    
    @IBAction func cancelPressed(_ sender: NSButton) {
        self.view.window?.sheetParent?.endSheet(self.view.window!, returnCode: NSModalResponseCancel)
    }
    
    @IBAction func importPressed(_ sender: NSButton) {
        self.view.window?.sheetParent?.endSheet(self.view.window!, returnCode: NSModalResponseOK)

    }
}
