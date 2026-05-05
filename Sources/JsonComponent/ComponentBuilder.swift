import SwiftUI

struct ComponentBuilder: View {
    var cContext: ComponentContext
    var component: BaseJsonComponent
    var setState: ((@escaping (ComponentState) -> Void) -> Void)? = nil
    var onDispose: (() -> Void)? = nil

    init(
        cContext: ComponentContext,
        component: BaseJsonComponent,
        setState: ((@escaping (ComponentState) -> Void) -> Void)? = nil,
        onDispose: (() -> Void)? = nil,
    ) {
        self.cContext = cContext
        self.component = component
        self.setState = setState
        self.onDispose = onDispose

        if let initialState = component.state {
            self.state = initialState
        } else {
            self.state = [:]
        }
        self.setState?(updateState)
        component.initState()
    }

    @State private var state: ComponentState

    private func updateState(_ value: ComponentState) {
        state = state.merging(value) { $1 }
    }

    var body: some View {
        return AnyView(
            component.build(cContext.merging(["state": state]) { $1 })
        )
        .onDisappear {
            onDispose?()
            component.dispose()

        }

    }
}
