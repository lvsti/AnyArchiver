//
//  PezBrowser.swift
//  AnyArchiver
//
//  Created by Tamas Lustyik on 2015. 12. 20..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum PezBrowserError: ErrorType {
    case PreviewNotFound
}

public class PezBrowser {
    
    private let _archiver: IArchiver
    
    public init(archiver: IArchiver) {
        _archiver = archiver
    }
    
    public func previewDataForPezAtURL(url: NSURL) throws -> NSData {
        let archive = try _archiver.archiveWithURL(url, createIfMissing: false)
        for entry in archive.entries {
            if entry.name == "prezi/preview.png" {
                return try entry.extractedData()
            }
        }
        throw PezBrowserError.PreviewNotFound
    }
    
}

