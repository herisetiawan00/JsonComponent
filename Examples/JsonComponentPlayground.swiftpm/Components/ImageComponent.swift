import JsonComponent
import SwiftUI

@MainActor
struct ImageComponent: BaseJsonComponent {
    static let id: String = "image"

    var key: String? = nil
    var state: ComponentState? = nil

    init(systemName: String) {
        self.systemName = systemName
    }

    var systemName: String

    static func fromJson(json: ComponentJson) throws -> ImageComponent {
        return ImageComponent(
            systemName: json["systemName"] as! String,
        )
    }

    func build(_ cContext: ComponentContext) -> any View {
        return Image(systemName: systemName)
    }

    func initState() {}

    func dispose() {}
}
