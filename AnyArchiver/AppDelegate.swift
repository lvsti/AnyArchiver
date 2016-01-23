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
        let factory = ArchiverFactory()
        factory.registerArchiver(ZipZapArchiver())
        factory.registerArchiver(SevenZipArchiver())
        
        do {
            let browser = PezBrowser(factory: factory)
            let imageData = try browser.previewDataForPezAtURL(NSBundle.mainBundle().URLForResource("test", withExtension: "pez")!)
            imageView.image = NSImage(data: imageData)

            let writer = PortableWriter(factory: factory)
            try writer.setVersion(42, forPortableAtURL: NSBundle.mainBundle().URLForResource("portable", withExtension: "7z")!)
        } catch {
            NSLog("oops")
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

