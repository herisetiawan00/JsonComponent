import SwiftUI
import JsonComponent

@MainActor
struct TextComponent: BaseJsonComponent {
    static let id: String = "text"
    
    var key: String? = nil
    var state: ComponentState? = nil

    init(value: String, key: String? = nil, state: ComponentState? = nil) {
        self.key = key
        self.value = value
        self.state = state
    }

    var value: String

    static func fromJson(json: ComponentJson) throws -> TextComponent {
        return TextComponent(
            value: json["value"] as! String,
            key: json["_key"] as! String?,
            state: json["_state"] as! [String: Any]?,
        )
    }

    func build(_ cContext: ComponentContext) -> any View {
        return Text(value.withContext(cContext))
    }

    func initState() {}

    func dispose() {}
}
