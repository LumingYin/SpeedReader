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
    @IBOutlet var contentTextView: NSTextView!
    @IBOutlet weak var guidanceView: NSView!
    @IBOutlet weak var outerTextScrollView: NSScrollView!
    
    
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
    
    @IBAction func createArticle(_ sender: NSButton) {
        if let vc = storyboard?.instantiateController(withIdentifier: "BlankDocument") as? NSViewController {
            self.presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY, behavior: .transient)
        }
    }

}

