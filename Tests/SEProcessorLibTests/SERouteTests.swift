//
//  SERouteTests.swift
//  SEProcessorLibTests
//
//  Created by Brandon Holden on 8/30/18.
//

import Foundation
import XCTest
import SECommon
@testable import SEProcessorLib


private final class FileManagerTestUtil: FileManagerProtocol {
    public func fileExists(atPath path: String) -> Bool {
        return true
    }
    public func contentsOfDirectory(atPath path: String) -> [String] {
        return [String]()
    }
    public func moveItem(atPath: String, toPath: String) {
        
    }
}


class SERouteTests: XCTestCase {
    
    var route: SERoute!
    
    override func setUp() {
        SEGlobals.DOCUMENT_ROOT = "/var/swiftengine/www"
        let fm = FileManagerTestUtil()
        self.route = SERoute(fileManager: fm)
    }
    
    
    // Swift file
    func testSwiftExecutable() {
        let file = "hello.swift"
        let (exeType, path) = self.route.getExecutableType(file)
        XCTAssertEqual(exeType, ExcutableType.swift)
        XCTAssertEqual(path, "\(SEGlobals.DOCUMENT_ROOT)/hello.swift")
    }
    
    
    // A shell script/anything not `.swift`
    func testShellExecutable() {
        let file = "hello.sh"
        let (exeType, path) = self.route.getExecutableType(file)
        XCTAssertEqual(exeType, ExcutableType.staticFile)
        XCTAssertEqual(path, "\(SEGlobals.DOCUMENT_ROOT)/hello.sh")
    }
    
    
    
    
}
