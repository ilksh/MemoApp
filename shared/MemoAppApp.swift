import SwiftUI

@main
struct MemoAppApp: App {
    @StateObject var store = MemoStore()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainListVIew()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
        }
    }
}
