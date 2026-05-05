import Foundation

protocol ComponentException: Error, CustomStringConvertible {
    var message: String { get }
    var stackTrace: [String] { get }
}

extension ComponentException {
    public var description: String {
        return "\(String(describing: type(of: self))): \(message)"
    }
}

public struct ComponentRegisteredException: ComponentException {
    let message: String
    let stackTrace: [String]
    
    init(_ id: String, _ stackTrace: [String] = Thread.callStackSymbols) {
        self.message = "component \(id) already registered"
        self.stackTrace = stackTrace
    }
}

public struct ComponentNotFoundException: ComponentException {
    let message: String
    let stackTrace: [String]
    
    init(_ id: String, _ stackTrace: [String] = Thread.callStackSymbols) {
        self.message = "component \(id) not found"
        self.stackTrace = stackTrace
    }
}

public struct ComponentInvalidException: ComponentException {
    let json: String?
    let message: String
    let stackTrace: [String]
    
    init(_ json: ComponentJson, _ stackTrace: [String] = Thread.callStackSymbols) {
        self.json = json.toString()
        self.message = "component invalid"
        self.stackTrace = stackTrace
    }
}

public struct ComponentParsingException: ComponentException {
    let json: String?
    let message: String
    let stackTrace: [String]
    
    init(_ json: ComponentJson, _ stackTrace: [String] = Thread.callStackSymbols) {
        self.json = json.toString()
        self.message = "component parsing failed"
        self.stackTrace = stackTrace
    }
}
