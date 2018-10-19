//
//  popUpController.swift
//  gustave
//
//  Created by Alexis Benoliel on 18/10/2018.
//  Copyright © 2018 Alexis Benoliel. All rights reserved.
//

import Cocoa
import SwiftHEXColors

class popUpController: NSWindowController, ChangeMenuColorDelegate {
    
    func changeMenuColor() {
        print("color")
    }
    

    @IBOutlet weak var mainToolBar: NSToolbar!
    
    override func windowDidLoad() {
        super.windowDidLoad()

        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.styleMask.insert(.fullSizeContentView)
        mainToolBar.showsBaselineSeparator = false
        
        
    }
}
