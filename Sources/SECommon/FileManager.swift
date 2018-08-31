//
//  SEFileManager.swift
//  SwiftEngineServerLib
//
//  Created by Brandon Holden on 8/28/18.
//

import Foundation


public protocol FileManagerProtocol {
    func fileExists(atPath path: String) -> Bool
    func contentsOfDirectory(atPath path: String) throws -> [String]
    func moveItem(atPath: String, toPath: String) throws
}

public class FileManager: FileManagerProtocol {
    public init() {}
    public func fileExists(atPath path: String) -> Bool {
        return Foundation.FileManager.default.fileExists(atPath: path)
    }
    public func contentsOfDirectory(atPath path: String) throws -> [String] {
        return try Foundation.FileManager.default.contentsOfDirectory(atPath: path)
    }
    public func moveItem(atPath: String, toPath: String) throws {
        try Foundation.FileManager.default.moveItem(atPath: atPath, toPath: toPath)
    }
}
