//
//  AppDelegate.swift
//  AnyArchiver
//
//  Created by Tamas Lustyik on 2015. 12. 20..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Cocoa
import UltimateFramework


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var imageView: NSImageView!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        ArchiverFactory.registerArchiver(ZipZapArchiver())
        ArchiverFactory.registerArchiver(SevenZipArchiver())
        
        let browser = PezBrowser(archiverFactory: ArchiverFactory())
        
        do {
            let imageData = try browser.previewDataForPezAtURL(NSBundle.mainBundle().URLForResource("test", withExtension: "pez")!)
            imageView.image = NSImage(data: imageData)
        } catch {
            NSLog("oops")
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

