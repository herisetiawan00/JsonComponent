import JsonComponent
import SwiftUI

enum Direction: String {
    case Horizontal
    case Vertical
    case Stack
}

@MainActor
struct MultiComponent: BaseJsonComponent {
    static let id: String = "multi"
    var key: String? = nil
    var state: ComponentState? = nil

    init(children: [ComponentJson], direction: Direction) {
        self.children = children
        self.direction = direction
    }

    var children: [ComponentJson]
    var direction: Direction

    static func fromJson(json: ComponentJson) throws -> MultiComponent {
        return MultiComponent(
            children: json["children"] as! [ComponentJson],
            direction: Direction(rawValue: json["direction"] as! String)
                ?? .Vertical
        )
    }

    func build(_ cContext: ComponentContext) -> any View {
        let childrenViews = children.map { child in
            try? AnyView(JsonComponent.build(child, cContext: cContext))
        }
        return switch direction {
        case .Horizontal:
            HStack {
                ForEach(0..<childrenViews.count, id: \.self) { i in
                    childrenViews[i]
                }
            }
        case .Vertical:
            VStack {
                ForEach(0..<childrenViews.count, id: \.self) { i in
                    childrenViews[i]
                }
            }
        case .Stack:
            ZStack {
                ForEach(0..<childrenViews.count, id: \.self) { i in
                    childrenViews[i]
                }
            }
        }
    }

    func initState() {}

    func dispose() {}
}
