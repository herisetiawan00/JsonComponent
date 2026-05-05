# json_component

A json to swift widget component interpreter

## Getting Started

### Create component
```swift
/// A component that will build a text widget
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
```

### Register component
```swift
/// Component need to be registered to be work, componentId need to be unique per component
try? JsonComponent.register(TextComponent.id, TextComponent.fromJson)
```

### Using component
```swift
struct ContentView: View {
    ...

    var body: some View {
        try? AnyView(JsonComponent.build(component)) // your component here
    }
}
```


### Component JSON Structure
| Key   | Required | Unique | Description |
|-------|----------|--------|-------------|
| `_id` | Yes      | Yes    | This is the identifier of the component |
| `_state` | Depends | No | Initial state for the component |
| `_key` | Depends | Yes | component identifier for updating state |

### Updating state
```swift
    ...
    /// This state will be concated with previous state
    JsonComponent.setState(key, state);
```

### Using state in component
On the json component we can use state by putting `$state.` on the value, example:
```json
{
    "_id": "text",
    "_key": "title-component-key",
    "_state": {
        "value": "Initial Text",
        "nested": {
            "variable": "sample"
        }
    },
    "data": "$state.value" /// Initial Text
    "otherData": "$state.nested.variable" /// sample
}
```
Then on the component you can use the `data` with `.withContext(...)` to translate the key into real value.

```swift
func build(_ cContext: ComponentContext) -> any View {
    return Text(value.withContext(cContext))
}
```

_*if there is no matched pattern, it will return the key as is_

## Example
- WIP

## Maintainers
- [Heri Setiawan](https://github.com/herisetiawan00)
