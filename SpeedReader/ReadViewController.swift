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
    var article: Article?
    var articlePreference: Preference?
    var localWordsPerRoll: Int = 1
    
    @IBOutlet weak var visualEffectView: NSVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.displayLabel.stringValue = ""
        if let _ = font {
            self.displayLabel.font = font
        }
    }
    
    override func viewWillAppear() {
        guard var rect = self.view.window?.frame else {
            return
        }
        if let wordsPerRoll = articlePreference?.wordsPerRoll {
            localWordsPerRoll = Int(wordsPerRoll)
        }
        if (localWordsPerRoll == 1) {
            rect.size.width = 480
        } else if (localWordsPerRoll == 2) {
            rect.size.width = 580
        } else if (localWordsPerRoll == 3) {
            rect.size.width = 680
        } else if (localWordsPerRoll == 4) {
            rect.size.width = 780
        } else if (localWordsPerRoll == 5) {
            rect.size.width = 880
        } else {
            rect.size.width = 480
        }
        self.view.window?.setFrame(rect, display: true)
        if let hideBlur = articlePreference?.reduceTransparency {
            if hideBlur == true {
                visualEffectView.blendingMode = .withinWindow
            }
        }
        if let darkenBG = articlePreference?.increaseContrast {
            if darkenBG == true {
                visualEffectView.isHidden = true
            } else {
                visualEffectView.isHidden = false
            }
        }

        if enableDark {
            visualEffectView.material = .dark
            self.displayLabel.textColor = NSColor.white
            if let darkenBG = articlePreference?.increaseContrast {
                if darkenBG == true {
                    self.view.layer?.backgroundColor = NSColor.black.cgColor
                }
            }
        } else {
            visualEffectView.material = .light
            self.displayLabel.textColor = NSColor.black
            if let darkenBG = articlePreference?.increaseContrast {
                if darkenBG == true {
                    self.view.layer?.backgroundColor = NSColor.white.cgColor
                }
            }
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

    var timer: Timer?
    var isReading = false

    @IBAction func playPauseClicked(_ sender: Any) {
        if isReading {
            timer?.invalidate()
            isReading = false
        } else {
            runTimer()
        }
    }

    func startReading() {
        calculateReadingSpeed()
        if let text = textToRead {
            arrayText = text.stringTokens(splitMarks: [",","."," ","!",":","/","-","\n"])
//            arrayText = text.components(separatedBy: CharacterSet.init(charactersIn: ",. !:/-\n"))
            arrayText = arrayText.filter {
                $0 != ""
            }
            currentIndexInArray = 0
            runTimer()
        }
    }

    func runTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1 - readingSliderValue), repeats: true, block: { (timer) in
            if (self.currentIndexInArray < self.arrayText.count) {
                self.isReading = true
                var pendingString = ""
                for i in 0..<self.localWordsPerRoll {
                    if self.currentIndexInArray + i < self.arrayText.count {
                        pendingString = pendingString + self.arrayText[self.currentIndexInArray + i] + " "
                    }
                }
                self.displayLabel?.stringValue = pendingString
                self.currentIndexInArray = self.currentIndexInArray + self.localWordsPerRoll
            } else {
                self.isReading = false
                timer.invalidate()
                self.view.window?.close()
            }
        })
    }
    
}

extension String {

    func stringTokens(splitMarks: Set<String>) -> [String] {

        var string = ""
        var desiredOutput = [String]()
        for ch in self.characters {
            if splitMarks.contains(String(ch)) {
                if !string.isEmpty {
                    desiredOutput.append("\(string)\(ch)")
                }
//                desiredOutput.append(String(ch))
                string = ""
            }
            else {
                string += String(ch)
            }
        }
        if !string.isEmpty {
            desiredOutput.append(string)
        }
        return desiredOutput
    }
}
