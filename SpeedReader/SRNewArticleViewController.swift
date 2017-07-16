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
            article.content = "Speed reading is the art of silencing subvocalization. Most readers have an average reading speed of 200 wpm, which is about as fast as they can read a passage out loud. This is no coincidence. It is their inner voice that paces through the text that keeps them from achieving higher reading speeds. They can only read as fast as they can speak because that's the way they were taught to read, through reading systems like Hooked on Phonics.\n\nHowever, it is entirely possible to read at a much greater speed, with much better reading comprehension, by silencing this inner voice. The solution is simple - absorb reading material faster than that inner voice can keep up.\n\nIn the real world, this is achieved through methods like reading passages using a finger to point your way. You read through a page of text by following your finger line by line at a speed faster than you can normally read. This works because the eye is very good at tracking movement. Even if at this point full reading comprehension is lost, it's exactly this method of training that will allow you to read faster.\n\nWith the aid of software, it's much easier to achieve this same result with much less effort. Load a passage of text (like this one), and the software will pace through the text at a predefined speed that you can adjust as your reading comprehension increases.\n\nTo train to read faster, you must first find your base rate. Your base rate is the speed that you can read a passage of text with full comprehension. We've defaulted to 300 wpm, showing one word at a time, which is about the average that works best for our users. Now, read that passage at that base rate.\n\nAfter you've finished, double that speed by going to the Settings and changing the Words Per Minute value. Reread the passage. You shouldn't expect to understand everything - in fact, more likely than not you'll only catch a couple words here and there. If you have high comprehension, that probably means that you need to set your base rate higher and rerun this test again. You should be straining to keep up with the speed of the words flashing by. This speed should be faster than your inner voice can 'read'.\n\nNow, reread the passage again at your base rate. It should feel a lot slower – if not, try running the speed test again). Now try moving up a little past your base rate – for example, at 400 wpm – , and see how much you can comprehend at that speed.\n\nThat's basically it - constantly read passages at a rate faster than you can keep up, and keep pushing the edge of what you're capable of. You'll find that when you drop down to lower speeds, you'll be able to pick up much more than you would have thought possible.\n\nOne other setting that's worth mentioning in this introduction is the chunk size – the number of words that are flashed at each interval on the screen. When you read aloud, you can only say one word at a time. However, this limit does not apply to speed reading. Once your inner voice subsides and with constant practice, you can read multiple words at a time. This is the best way to achieve reading speeds of 1000+ wpm. Start small with 2 word chunk sizes and find out that as you increase, 3,4, or even higher chunk sizes are possible.\n\nGood luck!"
            article.lastUpdated = Date.init() as NSDate
            article.typeOfArticle = 0
            
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
                leftVC.getAllArticles()
            }
            
            presenting?.dismissViewController(self)
        }
        print("clicked")
    }
    
    @IBAction func importArticleClicked(_ sender: NSButton) {
        print("clicked")
        let openPanel = NSOpenPanel();
        openPanel.allowsMultipleSelection = false;
        openPanel.canChooseDirectories = false;
        openPanel.canCreateDirectories = false;
        openPanel.canChooseFiles = true;
        openPanel.allowedFileTypes = ["txt","rtf","pdf","doc", "docx", "pages"]
        openPanel.beginSheetModal(for: NSApp.mainWindow!) { (i) in
            if(i == NSModalResponseOK){
                print("Opened \(String(describing: openPanel.url))");
            } else {
                print("open cancelled")
            }
        }
    }
    
    @IBAction func importURLClicked(_ sender: NSButton) {
        print("clicked")
        if let webWindow = (storyboard?.instantiateController(withIdentifier: "OpenWebWindow") as? NSWindowController)?.window {
            NSApp.mainWindow?.beginSheet(webWindow, completionHandler: { (response: NSModalResponse) in
                print("sheet closed")
                if (response == NSModalResponseOK) {
                    if let webImport = webWindow.contentViewController as? SRImportWebViewController {
                        print("dismissed with url to import: \(webImport.urlLabel.stringValue)")
                    }
                } else if (response == NSModalResponseCancel) {
                    print("cancelled")
                }
            })
        }
        presenting?.dismissViewController(self)
    }
}

extension NSOpenPanel {
    var selectUrl: URL? {
        title = "Select File"
        allowsMultipleSelection = false
        canChooseDirectories = false
        canChooseFiles = true
        canCreateDirectories = false
        allowedFileTypes = ["txt","rtf","pdf","doc", "docx", "pages"]
        return runModal() == NSFileHandlingPanelOKButton ? urls.first : nil
    }
}
