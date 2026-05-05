import Foundation
import SwiftUI

@MainActor
public struct JsonComponent {
    private var registeredJson: [String: ComponentJsonBuilder] = [:]
    private var registeredState: [String: (ComponentState) -> Void] = [:]

    static var shared: JsonComponent = .init()

    public static func register(
        _ id: String,
        _ builder: @escaping ComponentJsonBuilder
    ) throws {
        if containsId(id) {
            throw ComponentRegisteredException(id, Thread.callStackSymbols)
        }

        shared.registeredJson[id] = builder

    }

    static private func containsId(_ id: String) -> Bool {
        return shared.registeredJson.contains(where: { $0.key == id })
    }

    public static func setState(_ key: String, _ state: ComponentState) {
        shared.registeredState[key]?(state)
    }

    public static func clear() {
        shared.registeredJson = [:]
        shared.registeredState = [:]
    }

    public static func build(
        _ json: ComponentJson,
        cContext: ComponentContext = [:]
    ) throws -> any View {
        guard let componentId: String = json["_id"] as? String else {
            throw ComponentInvalidException(json)
        }

        guard let builder = shared.registeredJson[componentId] else {
            throw ComponentNotFoundException(componentId)
        }

        guard let component = try? builder(json) else {
            throw ComponentParsingException(json)
        }

        return ComponentBuilder(
            cContext: cContext,
            component: component,
            setState: { callback in
                if let key = component.key {
                    shared.registeredState[key] = callback
                }
            },
            onDispose: {
                if let key = component.key {
                    shared.registeredState.removeValue(forKey: key)
                }
            }
        )
    }
}
