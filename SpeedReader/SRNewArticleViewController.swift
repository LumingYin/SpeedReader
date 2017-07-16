//
//  SRNewArticleViewController.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRNewArticleViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func newArticleClicked(_ sender: NSButton) {
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
            let article:Article = Article(context: context)
            article.typeOfArticle = 0
            article.content = "Paste in an article to get started."
            
            let preference: Preference = Preference(context: context)
            preference.fontFamily = "System Font"
            preference.fontSize = 24
            preference.isDark = false
            preference.language = "en_US"
            preference.speed = 0.5
            preference.wordsPerRoll = 1
            
            article.preference = preference
            
            (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
            
            if let leftVC = (NSApplication.shared().mainWindow?.contentViewController as? SRSplitViewController)?.splitViewItems[0].viewController as? SRHistoryViewController {
                leftVC.getAllHistory()
            }
        }
        print("clicked")
    }
    
    @IBAction func importArticleClicked(_ sender: NSButton) {
        print("clicked")
    }
    @IBAction func importURLClicked(_ sender: NSButton) {
        print("clicked")
    }
}
