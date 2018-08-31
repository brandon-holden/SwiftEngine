//
//  SEFileHandle.swift
//  SwiftEngineServerLib
//
//  Created by Brandon Holden on 8/28/18.
//

import Foundation


public protocol FileHandleProtocol  {
    func open(atPath path: String) throws
    func seekToEndOfFile() throws -> UInt64
    func write(_ data: Data) throws
    func closeFile() throws
}


public class FileHandle: FileHandleProtocol {
    public var fileHandle: Foundation.FileHandle!
    
    public init() { }
    
    public func open(atPath path: String) throws {
        // Ensure no other file is open
        guard self.fileHandle == nil else {
            throw RuntimeError("This instance already has a file handle open. Can't open new file at path: \(path)")
        }
        
        // Open the file and set instance var
        self.fileHandle = Foundation.FileHandle(forUpdatingAtPath: path)
        
        // Throw error if we could not open the file
        guard self.fileHandle != nil else {
            throw RuntimeError("Could not open file at path: \(path)")
        }
    }
    
    public func write(_ data: Data) throws {
        // Ensure file is open
        guard self.fileHandle != nil else {
            throw RuntimeError("Could not write. No file is open")
        }
        
        self.fileHandle.write(data)
    }
    
    public func closeFile() throws {
        guard self.fileHandle != nil else {
            throw RuntimeError("Could not close file. No file is open")
        }
        
        self.fileHandle.closeFile()
        self.fileHandle = nil
    }
    
    public func seekToEndOfFile() throws -> UInt64 {
        // Ensure file is open
        guard self.fileHandle != nil else {
            throw RuntimeError("Could not write. No file is open")
        }
        
        return self.fileHandle.seekToEndOfFile()
    }
    
}
