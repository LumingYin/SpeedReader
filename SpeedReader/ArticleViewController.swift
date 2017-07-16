//
//  ViewController.swift
//  SpeedReader
//
//  Created by Kay Yin on 7/3/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class ArticleViewController: NSViewController {
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
        
//        fontPopUp.removeAllItems()
//        fontPopUp.addItem(withTitle: "System Font")
//        fontPopUp.addItems(withTitles: allFontNames)
//        self.view.layer?.backgroundColor = NSColor.white.cgColor
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

//    @IBAction func speedReadClicked(_ sender: Any) {
//        openNewWindow()
//    }
    
//    NSArray *tagschemes = [NSArray arrayWithObjects:NSLinguisticTagSchemeLanguage, nil];
//    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:tagschemes options:0];
//    [tagger setString:@"Das ist ein bisschen deutscher Text. Bitte löschen Sie diesen nicht."];
//    NSString *language = [tagger tagAtIndex:0 scheme:NSLinguisticTagSchemeLanguage tokenRange:NULL sentenceRange:NULL];


    

}

