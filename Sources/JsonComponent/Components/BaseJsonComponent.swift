import SwiftUI

public protocol BaseJsonComponent {
    static var id: String { get }
    var key: String? { get }
    var state: ComponentState? { get set }

    static func fromJson(json: ComponentJson) throws -> Self

    func build(_ cContext: ComponentContext) -> any View

    func initState()

    func dispose()
}
