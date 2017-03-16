//
//  SKStyleKitSource.swift
//  SKStyleKit
//
//  Created by Мотылёв Михаил on 09/03/2017.
//  Copyright © 2017 mmotylev. All rights reserved.
//

import Foundation

enum SKStyleKitSourceLocation {
    
    case bundle(Bundle)
    case file(String)
}

enum SKStylesSourceType: Int {
    
    case main = 1
    case styleKit = -1
    case other = 0
}

public final class SKStyleKitSource {
    
    // MARK: - Properties -
    let location: SKStyleKitSourceLocation
    let type: SKStylesSourceType
    let zIndex: Int
    
    // MARK: - Init -
    private init(location: SKStyleKitSourceLocation, type: SKStylesSourceType, zIndex: Int) {
        
        self.location = location
        self.type = type
        self.zIndex = zIndex
    }
    
    // MARK: - Providers -
    func getProviders() -> [SKStylesSourceProvider] {
        
        let files: [String]
        
        switch location {
        
            case .bundle(let bundle):
                
                guard let bundleFiles = try? FileManager.default.contentsOfDirectory(atPath: bundle.bundlePath) else { return [] }
                files = bundleFiles.filter({ $0.hasPrefix("style") && $0.hasSuffix(".json") }).flatMap({ bundle.path(forResource: $0, ofType: nil) })
                
            case .file(let path): files = [path]
        }
        
        return files.flatMap { SKStylesSourceProvider(filePath: $0, sourceType: type, zIndex: zIndex) }
    }
    
    // MARK: - Factory -
    public class func main() -> SKStyleKitSource {
        return SKStyleKitSource(location: .bundle(Bundle.main), type: .main, zIndex: 0)
    }
    
    public class func styleKit() -> SKStyleKitSource {
        return SKStyleKitSource(location: .bundle(Bundle(for: SKStyleKitSource.self)), type: .styleKit, zIndex: 0)
    }
    
    public class func file(_ path: String, zIndex: Int = 0) -> SKStyleKitSource {
        return SKStyleKitSource(location: .file(path), type: .other, zIndex: zIndex)
    }

    public class func bundle(_ bundle: Bundle, zIndex: Int = 0)-> SKStyleKitSource {
        return SKStyleKitSource(location: .bundle(bundle), type: .other, zIndex: zIndex)
    }
}
