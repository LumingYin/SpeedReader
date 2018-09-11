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
    }
    
    
    
    @IBAction func contentLanguageChanged(_ sender: NSPopUpButton) {
    }
    
    @IBAction func collapse(_ sender: NSButton) {
        if (sender != disclosureTriangle) {
            if (disclosureTriangle.state == .on) {
                disclosureTriangle.state = .on
            } else {
                disclosureTriangle.state = .on
            }
        }

        if let delegate = delegate {
            delegate.collapseLanguage = !(delegate.collapseLanguage)
            delegate.updateHeight()
        }
    }
    
    override func configure() {
        if delegate?.article == nil {
            contentLanguagePopUp.isEnabled = false
        } else {
            contentLanguagePopUp.isEnabled = true
        }
        if let language = self.delegate?.article?.content?.guessLanguage() {
            contentLanguagePopUp.removeAllItems()
            contentLanguagePopUp.addItem(withTitle: "Auto Detect (\(language))")
        }
    }
}

extension String {
    func guessLanguage() -> String {
        let length = self.utf16.count
        let languageCode = CFStringTokenizerCopyBestStringLanguage(self as CFString, CFRange(location: 0, length: length)) as String? ?? ""
        
        let locale = Locale(identifier: languageCode)
        return locale.localizedString(forLanguageCode: languageCode) ?? "Unknown"
    }
}

