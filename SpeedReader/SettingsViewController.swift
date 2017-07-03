//
//  ViewController.swift
//  SpeedReader
//
//  Created by Kay Yin on 7/3/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {
    @IBOutlet weak var contentLabel: NSTextField!
    @IBOutlet var contentTextView: NSTextView!
    @IBOutlet weak var preferencesLabel: NSTextField!
    @IBOutlet weak var speedLabel: NSTextField!
    @IBOutlet weak var speedSlider: NSSlider!
    @IBOutlet weak var fontLabel: NSTextField!
    @IBOutlet weak var fontPopUp: NSPopUpButton!
    @IBOutlet weak var speedReadButton: NSButton!
    
    
    var detailWindow: ReadDetailWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true

//        self.view.layer?.backgroundColor = NSColor.white.cgColor
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func speedReadClicked(_ sender: Any) {
        openNewWindow()
    }

    
    func openNewWindow() {
        detailWindow = storyboard?.instantiateController(withIdentifier: "ReadDetailWindow") as? ReadDetailWindow
        if let readVC = detailWindow?.contentViewController as? ReadViewController {
            readVC.readingSliderValue = speedSlider.floatValue
            readVC.textToRead = contentTextView.string
        }
        detailWindow?.showWindow(self)
    }

}

