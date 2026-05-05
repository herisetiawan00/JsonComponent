import JsonComponent
import SwiftUI

struct ContentView: View {
    var component: ComponentJson = [
        "_id": "multi",
        "direction": "Vertical",
        "children": [
            [
                "_id": "image",
                "systemName": "globe",
            ],
            [
                "_id": "text",
                "_state": [
                    "data": "Lorem Ipsum"
                ],
                "value": "$state.data",
            ],
        ],
    ]

    var body: some View {
        try? AnyView(JsonComponent.build(component))
    }
}
