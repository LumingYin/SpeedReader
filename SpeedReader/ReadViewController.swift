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
    var fontName: String = "System Font"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
//        self.view.layer?.backgroundColor = NSColor.white.cgColor
        self.displayLabel.stringValue = ""
        if fontName == "System Font" {
            self.displayLabel.font = NSFont.systemFont(ofSize: 21.0)
        } else {
            self.displayLabel.font = NSFont.init(name: fontName, size: 21.0)
        }
    }
    
    override func viewDidAppear() {
        self.displayLabel.font = NSFont.init(name: fontName, size: 21.0)
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
            var arrayText = text.components(separatedBy: CharacterSet.init(charactersIn: ",. !:/-\n"))
            arrayText = arrayText.filter {
                $0 != ""
            }
//            print("arrayText: \(arrayText)")
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
