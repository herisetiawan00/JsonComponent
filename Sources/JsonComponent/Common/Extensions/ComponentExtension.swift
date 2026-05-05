import Foundation

public extension ComponentJson {
    func toString() -> String? {
        if let jsonData = try? JSONSerialization.data(
            withJSONObject: self,
            options: .prettyPrinted
        ),
            let str = String(data: jsonData, encoding: .utf8)
        {
            return str
        }
        return nil
    }
}
