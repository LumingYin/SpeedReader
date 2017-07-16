//
//  SRImportWebViewController.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa
import Kanna

class SRImportWebViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet weak var urlLabel: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    var dotDotDotTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getClipboardURL()
        urlLabel.delegate = self
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        parseWebpageAsync()
    }
    
    
    @IBAction func cancelPressed(_ sender: NSButton) {
        (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext.reset()
        self.view.window?.sheetParent?.endSheet(self.view.window!, returnCode: NSModalResponseCancel)
    }
    
    @IBAction func importPressed(_ sender: NSButton) {
        (NSApp.delegate as? AppDelegate)?.saveAction(nil)
        self.view.window?.sheetParent?.endSheet(self.view.window!, returnCode: NSModalResponseOK)
    }
    
    func parseWebpageAsync() {
        dotDotDotTimer?.invalidate()
        self.titleLabel.stringValue = "Loading..."
        dotDotDotTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true, block: { (timer) in
            if self.titleLabel.stringValue.contains("...") {
                self.titleLabel.stringValue = "Loading"
            } else if self.titleLabel.stringValue.contains("..") {
                self.titleLabel.stringValue = "Loading..."
            } else if self.titleLabel.stringValue.contains(".") {
                self.titleLabel.stringValue = "Loading.."
            } else {
                self.titleLabel.stringValue = "Loading."
            }
        })
        guard let url = URL(string: urlLabel.stringValue) else {
            self.titleLabel.stringValue = "Invalid Web URL"
            self.dotDotDotTimer?.invalidate()
            return
        }
        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("\(String(describing: error))")
                self.setLabelUnavailable()
            } else {
                guard let data = data,
                    let html:String = String(data: data, encoding: String.Encoding.utf8),
                    let doc = HTML(html: html, encoding: .utf8),
                    let title = doc.title else {
                    self.setLabelUnavailable()
                    return
                }
                var articleContent = ""
                for link in doc.xpath("//p | //h1 | //h2") {
                    guard let text = link.text else {
                        return
                    }
                    articleContent = articleContent + text + "\n"
//
//                    print(link.text)
//                    print(link["href"])
                }
//                for td in body {
//                }
                DispatchQueue.main.async {
                    guard let context = (NSApp.delegate as? AppDelegate)?.persistentContainer.viewContext else {
                        return
                    }
                    let newArticle: Article = Article(context: context)
                    newArticle.typeOfArticle = 2
                    newArticle.webPageUrl = self.urlLabel.stringValue
                    newArticle.lastUpdated = Date.init() as NSDate
                    newArticle.webPageTitle = title
                    newArticle.content = "\(title)\n\(articleContent)"
                    
                    self.titleLabel.stringValue = title
                    self.dotDotDotTimer?.invalidate()
                }

            }
            }.resume()
    }
    
    func setLabelUnavailable() {
        DispatchQueue.main.async {
            self.titleLabel.stringValue = "Unavailable"
            self.dotDotDotTimer?.invalidate()
        }
    }
    
    func getClipboardURL() {
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    if type == "public.utf8-plain-text" {
                        if let url = item.string(forType: type) {
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
