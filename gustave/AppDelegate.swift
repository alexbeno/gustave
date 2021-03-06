//
//  AppDelegate.swift
//  gustave
//
//  Created by Alexis Benoliel on 18/10/2018.
//  Copyright © 2018 Alexis Benoliel. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var contextMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    let popUpDraw = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "popUpID")) as! popUpController
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("menu-icone"))
            button.target = self
            button.action = #selector(self.clickHandler(sender:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func quitAppButton(_ sender: Any) {
        print("oucouc")
        NSApplication.shared.terminate(self)
    }
    
    @objc func clickHandler(sender: NSStatusItem) {
        print("oucou")
        statusItem.menu = nil

        let event = NSApp.currentEvent!
        
        if event.type == NSEvent.EventType.rightMouseUp {
            
            statusItem.menu = contextMenu
            statusItem.popUpMenu(contextMenu)
            
            statusItem.menu = nil
        } else {
            print("open pop up")
            popUpDraw.showWindow(self)
        }
        
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
}

struct globalConfig {
    static var view = "background"
    static var base = "none"
    static var theme = "white"
    static var library = "Random"
}

struct colorArray {
    static var googleMaterialColor = [
    "#F44336",
    "#FFEBEE",
    "#FFCDD2",
    "#EF9A9A",
    "#E57373",
    "#EF5350",
    "#F44336",
    "#E53935",
    "#D32F2F",
    "#C62828",
    "#B71C1C",
    "#FF8A80",
    "#FF5252",
    "#FF1744",
    "#D50000",
    "#E91E63",
    "#FCE4EC",
    "#F8BBD0",
    "#F48FB1",
    "#F06292",
    "#EC407A",
    "#E91E63",
    "#D81B60",
    "#C2185B",
    "#AD1457",
    "#880E4F",
    "#FF80AB",
    "#FF4081",
    "#F50057",
    "#C51162",
    "#9C27B0",
    "#F3E5F5",
    "#E1BEE7",
    "#CE93D8",
    "#BA68C8",
    "#AB47BC",
    "#9C27B0",
    "#8E24AA",
    "#7B1FA2",
    "#6A1B9A",
    "#4A148C",
    "#EA80FC",
    "#E040FB",
    "#D500F9",
    "#AA00FF",
    "#673AB7",
    "#EDE7F6",
    "#D1C4E9",
    "#B39DDB",
    "#9575CD",
    "#7E57C2",
    "#673AB7",
    "#5E35B1",
    "#512DA8",
    "#4527A0",
    "#311B92",
    "#B388FF",
    "#7C4DFF",
    "#651FFF",
    "#6200EA",
    "#3F51B5",
    "#E8EAF6",
    "#C5CAE9",
    "#9FA8DA",
    "#7986CB",
    "#5C6BC0",
    "#3F51B5",
    "#3949AB",
    "#303F9F",
    "#283593",
    "#1A237E",
    "#8C9EFF",
    "#536DFE",
    "#3D5AFE",
    "#304FFE",
    "#2196F3",
    "#E3F2FD",
    "#BBDEFB",
    "#90CAF9",
    "#64B5F6",
    "#42A5F5",
    "#2196F3",
    "#1E88E5",
    "#1976D2",
    "#1565C0",
    "#0D47A1",
    "#82B1FF",
    "#448AFF",
    "#2979FF",
    "#2962FF",
    "#03A9F4",
    "#E1F5FE",
    "#B3E5FC",
    "#81D4FA",
    "#4FC3F7",
    "#29B6F6",
    "#03A9F4",
    "#039BE5",
    "#0288D1",
    "#0277BD",
    "#01579B",
    "#80D8FF",
    "#40C4FF",
    "#00B0FF",
    "#0091EA",
    "#00BCD4",
    "#E0F7FA",
    "#B2EBF2",
    "#80DEEA",
    "#4DD0E1",
    "#26C6DA",
    "#00BCD4",
    "#00ACC1",
    "#0097A7",
    "#00838F",
    "#006064",
    "#84FFFF",
    "#18FFFF",
    "#00E5FF",
    "#00B8D4",
    "#009688",
    "#E0F2F1",
    "#B2DFDB",
    "#80CBC4",
    "#4DB6AC",
    "#26A69A",
    "#009688",
    "#00897B",
    "#00796B",
    "#00695C",
    "#004D40",
    "#A7FFEB",
    "#64FFDA",
    "#1DE9B6",
    "#00BFA5",
    "#4CAF50",
    "#E8F5E9",
    "#C8E6C9",
    "#A5D6A7",
    "#81C784",
    "#66BB6A",
    "#4CAF50",
    "#43A047",
    "#388E3C",
    "#2E7D32",
    "#1B5E20",
    "#B9F6CA",
    "#69F0AE",
    "#00E676",
    "#00C853",
    "#8BC34A",
    "#F1F8E9",
    "#DCEDC8",
    "#C5E1A5",
    "#AED581",
    "#9CCC65",
    "#8BC34A",
    "#7CB342",
    "#689F38",
    "#558B2F",
    "#33691E",
    "#CCFF90",
    "#B2FF59",
    "#76FF03",
    "#64DD17",
    "#CDDC39",
    "#F9FBE7",
    "#F0F4C3",
    "#E6EE9C",
    "#DCE775",
    "#D4E157",
    "#CDDC39",
    "#C0CA33",
    "#AFB42B",
    "#9E9D24",
    "#827717",
    "#F4FF81",
    "#EEFF41",
    "#C6FF00",
    "#AEEA00",
    "#FFEB3B",
    "#FFFDE7",
    "#FFF9C4",
    "#FFF59D",
    "#FFF176",
    "#FFEE58",
    "#FFEB3B",
    "#FDD835",
    "#FBC02D",
    "#F9A825",
    "#F57F17",
    "#FFFF8D",
    "#FFFF00",
    "#FFEA00",
    "#FFD600",
    "#FFC107",
    "#FFF8E1",
    "#FFECB3",
    "#FFE082",
    "#FFD54F",
    "#FFCA28",
    "#FFC107",
    "#FFB300",
    "#FFA000",
    "#FF8F00",
    "#FF6F00",
    "#FFE57F",
    "#FFD740",
    "#FFC400",
    "#FFAB00",
    "#FF9800",
    "#FFF3E0",
    "#FFE0B2",
    "#FFCC80",
    "#FFB74D",
    "#FFA726",
    "#FF9800",
    "#FB8C00",
    "#F57C00",
    "#EF6C00",
    "#E65100",
    "#FFD180",
    "#FFAB40",
    "#FF9100",
    "#FF6D00",
    "#FF5722",
    "#FBE9E7",
    "#FFCCBC",
    "#FFAB91",
    "#FF8A65",
    "#FF7043",
    "#FF5722",
    "#F4511E",
    "#E64A19",
    "#D84315",
    "#BF360C",
    "#FF9E80",
    "#FF6E40",
    "#FF3D00",
    "#DD2C00",
    "#795548",
    "#EFEBE9",
    "#D7CCC8",
    "#BCAAA4",
    "#A1887F",
    "#8D6E63",
    "#795548",
    "#6D4C41",
    "#5D4037",
    "#4E342E",
    "#3E2723",
    "#9E9E9E",
    "#FAFAFA",
    "#F5F5F5",
    "#EEEEEE",
    "#E0E0E0",
    "#BDBDBD",
    "#9E9E9E",
    "#757575",
    "#616161",
    "#424242",
    "#212121",
    "#607D8B",
    "#ECEFF1",
    "#CFD8DC",
    "#B0BEC5",
    "#90A4AE",
    "#78909C",
    "#607D8B",
    "#546E7A",
    "#455A64",
    "#37474F",
    "#263238",
    "#000000",
    "#FFFFFF",
    ];
    
    static var flatUiColor = ["#1abc9c", "#2ecc71", "#3498db", "#9b59b6", "#34495e", "#16a085", "#27ae60", "#2980b9", "#8e44ad", "#2c3e50", "#f1c40f", "#e67e22", "#e74c3c", "#ecf0f1", "#95a5a6", "#f39c12", "#d35400", "#c0392b", "#bdc3c7", "#7f8c8d"]
    
    static var flatblue = ["#4D8FAC","#5D8CAE","#22A7F0","#19B5FE","#59ABE3","#48929B","#317589","#89C4F4","#4B77BE","#1F4788","#003171","#044F67","#264348"]

    static var flatgrey = ["#BFBFBF","#F2F1EF","#BDC3C7","#ECF0F1","#D2D7D3","#757D75","#EEEEEE","#ABB7B7","#6C7A89","#95A5A6"]
    
    static var flatgreen = ["#7A942E","#8DB255","#5B8930","#6B9362","#407A52","#006442","#87D37C","#26A65B","#26C281","#049372","#2ABB9B","#16A085","#36D7B7","#03A678","#4DAF7C"]

//    -----
    static var flatpink = ["#F47983","#DB5A6B","#C93756","#FCC9B9","#FFB3A7","#F62459","#F58F84"]
    
    static var flatpurple = ["#875F9A","#5D3F6A","#89729E","#763568","#763568","#A87CA0","#5B3256","#BF55EC","#8E44AD","#9B59B6","#BE90D4"]

    static var flatred = ["#C91F37","#DC3023","#9D2933","#CF000F","#E68364","#F22613","#CF3A24","#C3272B","#8F1D21","#D24D57"]
    
    static var flatyellow = ["#D9B611","#F3C13A","#F7CA18","#E2B13C","#A17917","#F5D76E","#F4D03F","#FFA400","#E08A1E","#FFB61E","#FAA945","#FFA631","#FFB94E","#E29C45","#F9690E","#CA6924","#F5AB35"]
    
    static var shemeFromBase = [String]()

}



