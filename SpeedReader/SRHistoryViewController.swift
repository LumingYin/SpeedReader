//
//  SRHistoryViewController.swift
//  SpeedReader
//
//  Created by Bright on 7/16/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class SRHistoryViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet weak var tableView: NSTableView!
    var articles:[Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getAllArticles()
    }
    
    func getAllArticles() {
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
            do {
                let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastUpdated", ascending: false)]
                articles = try context.fetch(fetchRequest)
            } catch {
                print("Fetch article failed")
            }
        }
        if tableView != nil {
            tableView.reloadData()
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let view = tableView.make(withIdentifier: "HistoryEntryCell", owner: self) as? SRArticleSnippetCellView {
            let article = articles[row]
            if let time = article.lastUpdated {
                view.articleTime.stringValue = time.description
            }
            if let content = article.content {
                view.articleSummary.stringValue = content
            }
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 75
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = tableView.selectedRow
        print(tableView.selectedRow)
        if row == -1 {
            return
        }
        let article = articles[row]
        if let articleVC = (NSApplication.shared().mainWindow?.contentViewController as? SRSplitViewController)?.splitViewItems[1].viewController as? ArticleViewController {
            articleVC.article = article
            articleVC.updateToReflectArticle()
        }
        if let preferenceVC = (NSApplication.shared().mainWindow?.contentViewController as? SRSplitViewController)?.splitViewItems[2].viewController as? SRPreferencesViewController {
            preferenceVC.article = article
            preferenceVC.updateToReflectArticle()
        }

    }
}
