import JsonComponent

struct Components {
    @MainActor static func setUp() {
        try? JsonComponent.register(TextComponent.id, TextComponent.fromJson)
        try? JsonComponent.register(ImageComponent.id, ImageComponent.fromJson)
        try? JsonComponent.register(MultiComponent.id, MultiComponent.fromJson)

    }

}
