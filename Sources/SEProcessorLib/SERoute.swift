
import Foundation
import SECommon
import class SECommon.FileManager

public enum ExcutableType {
  case notFound
  case swift
  case staticFile
}


public class SERoute {
    
    let fileManger: FileManagerProtocol
    
    public init(fileManager: FileManagerProtocol, directory: String) {
        self.fileManger = fileManager
        SEGlobals.DOCUMENT_ROOT = directory
    }

    public init(fileManager: FileManagerProtocol) {
        self.fileManger = fileManager
    }

    public func doesRouterExist() -> Bool {
        let routerPath = "\(SEGlobals.DOCUMENT_ROOT)/Router.swift"
        return self.fileManger.fileExists(atPath: routerPath)
    }

    public func getExecutableType(_ requestFile: String) -> (ExcutableType, String) {
        let excutePath = "\(SEGlobals.DOCUMENT_ROOT)/\(requestFile)"
        if requestFile.range(of: ".") != nil {
            let fileExtension = requestFile.components(separatedBy: ".")[1]
      
            if fileExtension == "swift" {
                return (.swift, excutePath)
            }
            else {
                return (.staticFile, excutePath)
            }
        }
        else {
            // Add extension .swift
            let paths = requestFile.components(separatedBy: "/")
            var tempPath = SEGlobals.DOCUMENT_ROOT
            for i in 1..<paths.count {
                tempPath += "/\(paths[i])"
                let path = "\(tempPath).swift"
                if self.fileManger.fileExists(atPath: path) {
                    return (.swift, path)
                }
            }
          
            let path = SEGlobals.DOCUMENT_ROOT + requestFile + "/default.swift"
            if self.fileManger.fileExists(atPath: path) {
                return (.swift, path)
            }
        }
        return (.notFound, excutePath)
    }

}
