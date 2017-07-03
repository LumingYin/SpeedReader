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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
//        self.view.layer?.backgroundColor = NSColor.white.cgColor
        self.displayLabel.stringValue = ""
    }
    
    override func viewDidAppear() {
        startReading()
    }
    
    func calculateReadingSpeed() {
        if (readingSliderValue <= 0) {
            readingSliderValue = 0.01
        }
        readingSpeed = UInt32(60.0/readingSliderValue) * UInt32(ms)
        
    }
    
    func startReading() {
        calculateReadingSpeed()
        if let text = textToRead {
            let arrayText = text.components(separatedBy: CharacterSet.init(charactersIn: ",. !:/-\n"))
            DispatchQueue.global(qos: .background).async {
                // 60 least
                usleep(self.readingSpeed)
                for word in arrayText {
                    DispatchQueue.main.async {
                        self.displayLabel?.stringValue = word
                    }
                    usleep(self.readingSpeed)
                }
                usleep(self.readingSpeed)
                DispatchQueue.main.async {
                    self.view.window?.close()
                }

                
            }

        }
    }
    
    
}
