//
//  SRArticleSnippetCellView.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRArticleSnippetCellView: NSTableCellView {

    @IBOutlet weak var iconView: NSImageView!
    @IBOutlet weak var articleSummary: NSTextField!
    @IBOutlet weak var articleTime: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
