import Foundation

extension String {
    func withContext(_ cContext: ComponentContext, args: [Any] = []) -> String {
        if self.hasPrefix("$") {
            let paths = self.dropFirst().components(separatedBy: ".")
            
            var position: Any = cContext
            
            for path in paths {
                if let dict = position as? [String: Any], let nextValue = dict[path] {
                    position = nextValue
                } else {
                    return self
                }
            }
            
            var resultString = String(describing: position)
            for arg in args {
                if let range = resultString.range(of: "%s") {
                    let argString = String(describing: arg)
                    resultString = resultString.replacingCharacters(in: range, with: argString)
                } else {
                    break
                }
            }
            
            return resultString
        }
        
        return self
    }
}
