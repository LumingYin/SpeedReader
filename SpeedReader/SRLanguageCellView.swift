//
//  SRLanguageCellView.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRLanguageCellView: SRGeneralPrefCellView {
    @IBOutlet weak var disclosureTriangle: NSButton!
    @IBOutlet weak var topLabel: NSButton!


    @IBOutlet weak var contentLanguagePopUp: NSPopUpButton!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    @IBAction func contentLanguageChanged(_ sender: NSPopUpButton) {
                if let article = delegate?.parent?.childViewControllers[1] as? SpeedReader.ArticleViewController {
                    var text = article.contentTextView.string
                    var tagSchemes = [NSLinguisticTagSchemeLanguage]
                    var tagger = NSLinguisticTagger.init(tagSchemes: tagSchemes, options: 0)
                    tagger.string = text
                    var pointer: NSRangePointer?
                    var range: NSRangePointer?
                    var language = tagger.tag(at: 0, scheme: NSLinguisticTagSchemeLanguage, tokenRange: pointer, sentenceRange: range)
                    print("language is likely \(language)")
                }

    }
    
    @IBAction func collapse(_ sender: NSButton) {
        if (sender != disclosureTriangle) {
            if (disclosureTriangle.state == NSOnState) {
                disclosureTriangle.state = NSOffState
            } else {
                disclosureTriangle.state = NSOnState
            }
        }

        if let delegate = delegate {
            delegate.collapseLanguage = !(delegate.collapseLanguage)
            delegate.updateHeight()
        }
    }
    
    //    NSArray *tagschemes = [NSArray arrayWithObjects:NSLinguisticTagSchemeLanguage, nil];
    //    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:tagschemes options:0];
    //    [tagger setString:@"Das ist ein bisschen deutscher Text. Bitte löschen Sie diesen nicht."];
    //    NSString *language = [tagger tagAtIndex:0 scheme:NSLinguisticTagSchemeLanguage tokenRange:NULL sentenceRange:NULL];

    
    override func configure() {
    }

}
