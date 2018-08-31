//
//  SECompilerTests
//  SEProcessorLibTests
//
//  Created by Brandon Holden on 8/29/18.
//

import Foundation
import XCTest
@testable import SEProcessorLib



class SECompilerRequireTests: XCTestCase {
    
    //
    // getRequiredFile tests
    //
    
    // Proper require syntax
    func testStandardRequire() {
        let line = "//se: require hello.swift"
        if let reqFile = SECompiler.getRequiredFile(line) {
            XCTAssertEqual("hello.swift", reqFile)
        }
        else {
            XCTFail()
        }
    }
    
    // Proper require syntax with full path specified
    func testStandardRequireFullPath() {
        let line = "//se: require /users/greetings/hello.swift"
        if let reqFile = SECompiler.getRequiredFile(line) {
            XCTAssertEqual("/users/greetings/hello.swift", reqFile)
        }
        else {
            XCTFail()
        }
    }
    
    // No space between 'se:' and 'require'
    func testRequireNoSpaceInRequire() {
        let line = "//se:require hello.swift"
        if let reqFile = SECompiler.getRequiredFile(line) {
            XCTAssertEqual("hello.swift", reqFile)
        }
        else {
            XCTFail()
        }
    }
    
    // Capitalized directive
    func testRequireCapitalized() {
        let line = "//SE: REQUIRE hello.swift"
        if let reqFile = SECompiler.getRequiredFile(line) {
            XCTAssertEqual("hello.swift", reqFile)
        }
        else {
            XCTFail()
        }
    }
    
    // No spaces at all
    func testRequireNoSpaces() {
        let line = "//se:requirehello.swift"
        if let reqFile = SECompiler.getRequiredFile(line) {
            XCTAssertEqual("hello.swift", reqFile)
        }
        else {
            XCTFail()
        }
    }
    
    // If there is extra characters in the comment
    func testRequireExtraneousCharacters() {
        let line = "//se: require hello.swift how are you?"
        if let reqFile = SECompiler.getRequiredFile(line) {
            XCTAssertEqual("hello.swift", reqFile)
        }
        else {
            XCTFail()
        }
    }
    
    // Require syntax but no file specified
    func testRequireNoFile() {
        let line = "//se: require"
        XCTAssertNil(SECompiler.getRequiredFile(line))
    }
    
    // Three forward slashes rather than two
    func testRequireInvalidCommentFormat() {
        let line = "///se: require hello.swift"
        XCTAssertNil(SECompiler.getRequiredFile(line))
    }
    
    // Partial syntax
    func testRequirePartialDirective() {
        let line = "//se: r"
        XCTAssertNil(SECompiler.getRequiredFile(line))
    }
    
    // Blank line
    func testRequireEmptyString() {
        let line = ""
        XCTAssertNil(SECompiler.getRequiredFile(line))
    }
    
    
    
    //
    // setPathComponents tests
    //
    
    // Test setting the path components with a root level executable
    func testValidPath() {
        SEGlobals.DOCUMENT_ROOT = "/var/swiftengine/www"
        let path = "\(SEGlobals.DOCUMENT_ROOT)/default.swift"
        SECompiler.setPathComponents(forPath: path)
        XCTAssertEqual(SECompiler.executableName, "default")
        XCTAssertEqual(SECompiler.relativePath, "/")
        XCTAssertEqual(SECompiler.fullExecutablePath, "\(SECompiler.binaryCompilationLocation)/default")
    }
    
    
    // Test setting the path components with a full path
    func testValidLongPath() {
        SEGlobals.DOCUMENT_ROOT = "/var/swiftengine/www"
        let path = "\(SEGlobals.DOCUMENT_ROOT)/people/users/default.swift"
        SECompiler.setPathComponents(forPath: path)
        XCTAssertEqual(SECompiler.executableName, "default")
        XCTAssertEqual(SECompiler.relativePath, "/people/users")
        XCTAssertEqual(SECompiler.fullExecutablePath, "\(SECompiler.binaryCompilationLocation)/people/users/default")
    }

    
    
}
