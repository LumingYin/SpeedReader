//
//  SRImportWebViewController.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRImportWebViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet weak var urlLabel: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    var dotDotDotTimer: Timer?
    var articleContent = ""
    var articleTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getClipboardURL()
        urlLabel.delegate = self
    }
    
    func controlTextDidChange(_ obj: Notification) {
        parseWebpageAsync()
    }
    
    
    @IBAction func cancelPressed(_ sender: NSButton) {
        self.view.window?.sheetParent?.endSheet(self.view.window!, returnCode: NSApplication.ModalResponse.cancel)
    }
    
    @IBAction func importPressed(_ sender: NSButton) {
        if articleContent == "" || articleTitle == "" {
            let alert = NSAlert.init()
            alert.messageText = "Invalid URL."
            alert.informativeText = "The URL you entered does not seem to be valid."
            alert.addButton(withTitle: "OK")
            alert.runModal()
            return
        }
        guard let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        let newArticle: Article = Article(context: context)
        newArticle.typeOfArticle = 2
        newArticle.webPageUrl = self.urlLabel.stringValue
        newArticle.lastUpdated = Date.init()
        newArticle.webPageTitle = titleLabel.stringValue
        newArticle.content = "\(articleContent)"
        
        let newPreference: Preference = Preference(context: context)
        newArticle.preference = newPreference
        
        (NSApp.delegate as? AppDelegate)?.saveAction(nil)
        self.view.window?.sheetParent?.endSheet(self.view.window!, returnCode: NSApplication.ModalResponse.OK)
        if let leftVC = (NSApplication.shared.mainWindow?.contentViewController as? SRSplitViewController)?.splitViewItems[0].viewController as? SRHistoryViewController {
            leftVC.getAllArticles()
        }
    }
    
    func parseWebpageAsync() {
//        articleContent = ""
//        articleTitle = ""
//        dotDotDotTimer?.invalidate()
//        self.titleLabel.stringValue = "Loading..."
//        dotDotDotTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true, block: { (timer) in
//            if self.titleLabel.stringValue.contains("...") {
//                self.titleLabel.stringValue = "Loading"
//            } else if self.titleLabel.stringValue.contains("..") {
//                self.titleLabel.stringValue = "Loading..."
//            } else if self.titleLabel.stringValue.contains(".") {
//                self.titleLabel.stringValue = "Loading.."
//            } else {
//                self.titleLabel.stringValue = "Loading."
//            }
//        })
//        guard let url = URL(string: urlLabel.stringValue) else {
//            self.titleLabel.stringValue = "Invalid Web URL"
//            self.dotDotDotTimer?.invalidate()
//            return
//        }
//        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
//            if error != nil {
//                print("\(String(describing: error))")
//                self.setLabelUnavailable()
//            } else {
//                guard let data = data,
//                    let html:String = String(data: data, encoding: String.Encoding.utf8),
//                    let doc = HTML(html: html, encoding: .utf8),
//                    let title = doc.title else {
//                    self.setLabelUnavailable()
//                    return
//                }
//                for link in doc.xpath("//p | //h1 | //h2 | //code") {
//                    guard let text = link.text else {
//                        return
//                    }
//                    self.articleContent = self.articleContent + text + "\n"
//                }
//                DispatchQueue.main.async {
//                    self.articleTitle = title
//                    self.titleLabel.stringValue = title
//                    self.dotDotDotTimer?.invalidate()
//                }
//
//            }
//            }.resume()
    }
    
    func setLabelUnavailable() {
        DispatchQueue.main.async {
            self.titleLabel.stringValue = "Unavailable"
            self.dotDotDotTimer?.invalidate()
        }
    }
    
    func getClipboardURL() {
        if let items = NSPasteboard.general.pasteboardItems {
            for item in items {
                for type in convertFromNSPasteboardPasteboardTypeArray(item.types) {
                    if type == "public.utf8-plain-text" {
                        if let url = item.string(forType: convertToNSPasteboardPasteboardType(type)) {
                            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                                urlLabel.stringValue = url
                                parseWebpageAsync()
                            }
                        }
                    }
                }
            }
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSPasteboardPasteboardTypeArray(_ input: [NSPasteboard.PasteboardType]) -> [String] {
	return input.map { key in key.rawValue }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSPasteboardPasteboardType(_ input: String) -> NSPasteboard.PasteboardType {
	return NSPasteboard.PasteboardType(rawValue: input)
}
