//
//  ReadViewController.swift
//  SpeedReader
//
//  Created by Kay Yin on 7/3/17.
//  Copyright © 2017 Kay Yin. All rights reserved.
//

import Cocoa

class ReadViewController: NSViewController {
    
    var textToRead: String?
    @IBOutlet weak var displayLabel: NSTextField!
    var readingSliderValue: Float = 1.0
    var readingSpeed: UInt32 = 60
    let ms = 1000
    var font: NSFont?
    var enableDark: Bool = false
    var arrayText: [String] = []
    var currentIndexInArray: Int = 0
    
    @IBOutlet weak var visualEffectView: NSVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
//        self.view.layer?.backgroundColor = NSColor.white.cgColor
        self.displayLabel.stringValue = ""
        if let _ = font {
            self.displayLabel.font = font
        }
    }
    
    override func viewWillAppear() {
        if enableDark {
            visualEffectView.material = .dark
            self.displayLabel.textColor = NSColor.white
        } else {
            visualEffectView.material = .light
            self.displayLabel.textColor = NSColor.black

        }
    }
    
    override func viewDidAppear() {
        if let _ = font {
            self.displayLabel.font = font
        }
        startReading()
    }
    
    func calculateReadingSpeed() {
        if (readingSliderValue <= 0) {
            readingSliderValue = 0.01
        }
        readingSpeed = UInt32(10.0/readingSliderValue) * UInt32(ms)
        
    }
    
    func startReading() {
        calculateReadingSpeed()
        if let text = textToRead {
            arrayText = text.components(separatedBy: CharacterSet.init(charactersIn: ",. !:/-\n"))
            arrayText = arrayText.filter {
                $0 != ""
            }
            currentIndexInArray = 0
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true, block: { (timer) in
                if (self.currentIndexInArray < self.arrayText.count) {
                    self.displayLabel?.stringValue = self.arrayText[self.currentIndexInArray]
                    self.currentIndexInArray = self.currentIndexInArray + 1
                } else {
                    timer.invalidate()
                    self.view.window?.close()
                }
            })
        }
    }
    
}
