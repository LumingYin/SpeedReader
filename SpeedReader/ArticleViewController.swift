//
//  ViewController.swift
//  SpeedReader
//
//  Created by Kay Yin on 7/3/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class ArticleViewController: NSViewController, NSTextViewDelegate {
    var article: Article?
    @IBOutlet weak var contentLabel: NSTextField!
    @IBOutlet var contentTextView: NSTextView!
    @IBOutlet weak var preferencesLabel: NSTextField!
    @IBOutlet weak var speedLabel: NSTextField!
    @IBOutlet weak var speedSlider: NSSlider!
    @IBOutlet weak var fontLabel: NSTextField!
    @IBOutlet weak var fontPopUp: NSPopUpButton!
    @IBOutlet weak var speedReadButton: NSButton!
    
    
    var detailWindow: ReadDetailWindow?
    var allFontNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        
        allFontNames = NSFontManager.shared().availableFontFamilies
        contentTextView.textContainerInset = NSSize(width: 20.0, height: 20.0)
        contentTextView.delegate = self
    }

    override var representedObject: Any? {
        didSet {
        }
    }
    
    func updateToReflectArticle() {
        if article != nil {
            self.contentTextView.string = article?.content
            self.contentTextView.scroll(CGPoint(x: 0, y: -50))
        }
    }
    
    func textDidChange(_ notification: Notification) {
        article?.content = contentTextView.string
        (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
    }

}

