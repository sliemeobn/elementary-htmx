actor Database {
    var model = Model()
    static let shared = Database()

    func addItem(_ item: String) {
        model.items.append(item)
    }

    func removeItem(at index: Int) -> Bool {
        if model.items.indices.contains(index) == false {
            return false
        }

        model.items.remove(at: index)
        return true
    }
}

struct Model {
    var items: [String] = []
}
