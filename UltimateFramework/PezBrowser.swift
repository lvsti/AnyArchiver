//
//  PezBrowser.swift
//  AnyArchiver
//
//  Created by Tamas Lustyik on 2015. 12. 20..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation
import ZipZap

public enum PezBrowserError: ErrorType {
    case PreviewNotFound
}

public class PezBrowser {
    
    public init() {}
    
    public func previewDataForPezAtURL(url: NSURL) throws -> NSData {
        let archive = try ZZArchive(URL: url)
        for entry in archive.entries {
            if entry.fileName == "prezi/preview.png" {
                return try entry.newData()
            }
        }
        throw PezBrowserError.PreviewNotFound
    }
    
}

