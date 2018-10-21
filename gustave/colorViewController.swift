//
//  colorViewController.swift
//  gustave
//
//  Created by Alexis Benoliel on 18/10/2018.
//  Copyright © 2018 Alexis Benoliel. All rights reserved.
//

import Cocoa
import SwiftHEXColors
import DynamicColor

protocol ChangeMenuColorDelegate: class {
    func changeMenuColor()
}

extension NSButton {
    
    func set(textColor color: NSColor) {
        let newAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
        let range = NSRange(location: 0, length: attributedTitle.length)
        
        newAttributedTitle.addAttributes([
            .foregroundColor: color,
            ], range: range)
        
        attributedTitle = newAttributedTitle
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension NSTextField{
    func controlTextDidChange(obj: NSNotification){}
    
}

extension String {
    
    var containsValidCharacter: Bool {
        let characterSet = CharacterSet(charactersIn: "123456789ABCDEFabcdef#")
        let range = (self as NSString).rangeOfCharacter(from: characterSet)
        return range.location != NSNotFound
    }
}

class colorViewController: NSViewController, NSTextFieldDelegate {
    
    weak var delegate: ChangeMenuColorDelegate?

    @IBOutlet weak var textViewBox: NSBox!
    @IBOutlet weak var backgroundBox: NSBox!
    @IBOutlet weak var hexaLabel: NSTextField!
    @IBOutlet weak var copiedToClipLabel: NSTextField!
    @IBOutlet weak var backgroundTxt: NSTextField!
    @IBOutlet weak var hexaLabelText: NSTextField!
    @IBOutlet weak var copiedToClipLabelText: NSTextField!
    
    // settings
    @IBOutlet weak var settingBox: NSBox!
    @IBOutlet weak var whiteThemeButtonEl: NSButton!
    @IBOutlet weak var blackThemeButtonEl: NSButton!
    @IBOutlet weak var backgroundButtonEl: NSButton!
    @IBOutlet weak var textButtonEL: NSButton!
    @IBOutlet weak var libraryButtonEl: NSPopUpButton!
    @IBOutlet weak var baseFieldEl: NSTextField!
    @IBOutlet weak var boxBaseBackground: NSBox!
    
    let hexaArray = ["#F44336","#9C27B0", "#4CAF50", "#03A9F4", "#FF4081", "#009688"]
    var currentHexaGlobal = "#009688"
    var base = globalConfig.base
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the initial state of NSTextField as hidden
        copiedToClipLabel.isHidden = true
        settingBox.isHidden = true
        
        backgroundButtonEl.set(textColor: NSColor(hexString: "C1C1C1"))
        textButtonEL.set(textColor: NSColor(hexString: "C1C1C1"))
        whiteThemeButtonEl.set(textColor: NSColor(hexString: "C1C1C1"))
        blackThemeButtonEl.set(textColor: NSColor(hexString: "C1C1C1"))
        
        baseFieldEl.delegate = self
        
        
        if(globalConfig.base != "none") {
           getShemeFromBase()
        }
        
        if(globalConfig.view == "background") {
            textViewBox.isHidden = true
            backgroundBox.isHidden = false
            backgroundButtonEl.set(textColor: NSColor(hexString: "222222"))
            textButtonEL.set(textColor: NSColor(hexString: "C1C1C1"))
        } else if(globalConfig.view == "text") {
            textViewBox.isHidden = false
            backgroundBox.isHidden = true
            backgroundButtonEl.set(textColor: NSColor(hexString: "C1C1C1"))
            textButtonEL.set(textColor: NSColor(hexString: "222222"))
        }

        if(globalConfig.theme == "white") {
            whiteThemeButtonEl.set(textColor: NSColor(hexString: "222222"))
            blackThemeButtonEl.set(textColor: NSColor(hexString: "C1C1C1"))
        } else if(globalConfig.theme == "black") {
            whiteThemeButtonEl.set(textColor: NSColor(hexString: "C1C1C1"))
            blackThemeButtonEl.set(textColor: NSColor(hexString: "222222"))
        }
        
        // allow view do receive keypress
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            if self.myKeyDown(with: $0) {
                if($0.keyCode == 49) {
                  return nil
                } else {
                    return $0
                }
            } else {
                return $0
            }
        }
    }
    
    
    // detect the keypress
    func myKeyDown(with event: NSEvent) -> Bool {

        guard let locWindow = self.view.window,
            NSApplication.shared.keyWindow === locWindow else { return false }
        
        changeBgColor()
        return true
    }
    
    func getHexFromColor(color: NSColor) -> NSString {
        // Get the red, green, and blue components of the color
        var r :CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        var rInt, gInt, bInt, aInt: Int
        var rHex, gHex, bHex: NSString
        
        var hexColor: NSString
        
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
//         println("R: \(r) G: \(g) B:\(b) A:\(a)")
        
        // Convert the components to numbers (unsigned decimal integer) between 0 and 255
        rInt = Int((r * 255.99999))
        gInt = Int((g * 255.99999))
        bInt = Int((b * 255.99999))
        
        hexColor = "#" + String(format:"%02X", Int(rInt)) + String(format:"%02X", Int(gInt)) + String(format:"%02X", Int(bInt)) as NSString
        
        return hexColor
    }
    
    
    func getRandomColor() -> String {
        let letters = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"]
        var color = "#"
        for _ in 1...6 {
            color += letters.randomItem()!
        }
        return color;
    }
    
    func getShemeFromBase()  {
        let baseColor = globalConfig.base
        let originalColor = DynamicColor(hexString: baseColor)
//        let lighterColor = originalColor.darkened()
//        let currentHexa = getHexFromColor(color: lighterColor)
        var indexLight : Float = 0
        var indexDark : Float = 0
        var indexSaturated : Float = 0
        
        for _ in 1...9 {
            indexLight = indexLight + 0.05
            let lighterColor = originalColor.lighter(amount: CGFloat(indexLight))
            let currentHexa = getHexFromColor(color: lighterColor)
            if !colorArray.shemeFromBase.contains(currentHexa as String) {
                if(currentHexa != "#FFFFFF") {
                    colorArray.shemeFromBase.append(currentHexa as String)
                }
            }
            print(colorArray.shemeFromBase)
        }
        
        for _ in 1...18 {
            indexDark = indexDark + 0.05
            let darkerColor = originalColor.darkened(amount: CGFloat(indexDark))
            let currentHexa = getHexFromColor(color: darkerColor)
            if !colorArray.shemeFromBase.contains(currentHexa as String) {
                if(currentHexa != "#000000") {
                 colorArray.shemeFromBase.append(currentHexa as String)
                }
            }
            print(colorArray.shemeFromBase)
        }
        
        for _ in 1...18 {
            indexSaturated = indexSaturated + 0.05
            let darkerColor = originalColor.saturated(amount: CGFloat(indexSaturated))
            let currentHexa = getHexFromColor(color: darkerColor)
            if !colorArray.shemeFromBase.contains(currentHexa as String) {
                if(currentHexa != "#000000" && currentHexa != "#000000") {
                    colorArray.shemeFromBase.append(currentHexa as String)
                }
            }
            print(colorArray.shemeFromBase)
        }
        
    }
    
    func changeBgColor() {
        var currentHexa = "#FFFFFF"
        
        
        if(base != globalConfig.base && globalConfig.base != "none") {
            getShemeFromBase()
            base = globalConfig.base
        }

        
        if(globalConfig.library == "Random") {
            currentHexa = getRandomColor()
        } else if(globalConfig.library == "Google material") {
            currentHexa = colorArray.googleMaterialColor.randomItem()!
        } else if(globalConfig.library == "with base") {
            if(globalConfig.base != "none") {
              currentHexa = colorArray.shemeFromBase.randomItem()!
            } else {
                currentHexa = getRandomColor()
            }
        }
        
        currentHexaGlobal = currentHexa as String
        
        if(globalConfig.view == "background") {
            backgroundBox.fillColor = NSColor(hexString: currentHexa as String)!
            hexaLabel.stringValue = currentHexa as String
        } else if(globalConfig.view == "text") {
            backgroundTxt.textColor = NSColor(hexString: currentHexa as String)!
            hexaLabelText.stringValue = currentHexa as String
        }
    
//
    }
    
    override func mouseDown(with theEvent : NSEvent) {

        // copy the hexa in user clipboard
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(currentHexaGlobal, forType: NSPasteboard.PasteboardType.string)

        // set the new state of NSTextField as show
        copiedToClipLabel.isHidden = false

        // set the new state of NSTextField as hidden
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.copiedToClipLabel.isHidden = true
        }
    }
    
    // open setting
    @IBAction func openSettingBgView(_ sender: Any) {
        settingBox.isHidden = false
        textViewBox.isHidden = true
        backgroundBox.isHidden = true
        
    }
    
    @IBAction func openSettingTextView(_ sender: Any) {
        settingBox.isHidden = false
        textViewBox.isHidden = true
        backgroundBox.isHidden = true
    }
    
    // view setting
    
    @IBAction func backgroundViewAction(_ sender: Any) {
        globalConfig.view = "background"
        backgroundButtonEl.set(textColor: NSColor(hexString: "222222"))
        textButtonEL.set(textColor: NSColor(hexString: "C1C1C1"))
    }
    
    @IBAction func textViewAction(_ sender: Any) {
        globalConfig.view = "text"
        backgroundButtonEl.set(textColor: NSColor(hexString: "C1C1C1"))
        textButtonEL.set(textColor: NSColor(hexString: "222222"))
    }
    
    
    // theme settings
    @IBAction func whiteThemeAction(_ sender: Any) {
    }
    @IBAction func blackThemeAction(_ sender: Any) {
    }
    
    // select library settings
    
    @IBAction func selectLibraryAction(_ sender: Any) {
        if let title = libraryButtonEl.titleOfSelectedItem {
            globalConfig.library = title
        }
    }
    
    
    // get base from user
    
    override func controlTextDidChange(_ obj: Notification)
    {
        var endValue = ""
        var value = baseFieldEl.stringValue
        var lastChar = ""
        
        if(value.count < 2) {
            lastChar = value
        } else {
            lastChar = String(value.last!)
        }
        
        if(lastChar.containsValidCharacter == true) {
            if(value.range(of:"#") != nil) {
                if(value.count < 7) {
                    // nil
                    globalConfig.base = "none"
                    boxBaseBackground.fillColor = NSColor(hexString: "#7B7B7B")
                } else if(value.count > 7) {
                    value = String(value.dropLast())
                    baseFieldEl.stringValue = value
                    boxBaseBackground.fillColor = NSColor(hexString: "#7B7B7B")!
                } else {
                    endValue = value
                    globalConfig.base = endValue
                    boxBaseBackground.fillColor = NSColor(hexString: endValue)!
                    if(globalConfig.view == "background") {
                        backgroundBox.fillColor = NSColor(hexString: endValue as String)!
                        hexaLabel.stringValue = endValue as String
                    } else if(globalConfig.view == "text") {
                        backgroundTxt.textColor = NSColor(hexString: endValue as String)!
                        hexaLabelText.stringValue = endValue as String
                    }
                }
            } else {
                if(value.count < 6) {
                    // nil
                    globalConfig.base = "none"
                    boxBaseBackground.fillColor = NSColor(hexString: "#7B7B7B")!
                } else if(value.count > 6) {
                    value = String(value.dropLast())
                    baseFieldEl.stringValue = value
                } else {
                    endValue = "#" + value
                    globalConfig.base = endValue
                    boxBaseBackground.fillColor = NSColor(hexString: endValue)!
                    if(globalConfig.view == "background") {
                        backgroundBox.fillColor = NSColor(hexString: endValue as String)!
                        hexaLabel.stringValue = endValue as String
                    } else if(globalConfig.view == "text") {
                        backgroundTxt.textColor = NSColor(hexString: endValue as String)!
                        hexaLabelText.stringValue = endValue as String
                    }
                    
                }
            }
        } else {
            value = String(value.dropLast())
            baseFieldEl.stringValue = value
        }
        
    }
    


    
    // save settings
    @IBAction func saveButtonAction(_ sender: Any) {
        settingBox.isHidden = true
        if(globalConfig.view == "background") {
            textViewBox.isHidden = true
            backgroundBox.isHidden = false

        } else if(globalConfig.view == "text") {
            textViewBox.isHidden = false
            backgroundBox.isHidden = true
        }
    }
    
    
}
