//
//  RuntimeError.swift
//  SECommon
//
//  Created by Brandon Holden on 8/30/18.
//

import Foundation


public struct RuntimeError: Error {
    let message: String

    public init(_ message: String, file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        self.message = "\(message) (File: \(file) Function: \(function) Line: \(line) Column: \(column))"
    }

    public var localizedDescription: String {
        return message
    }
}
