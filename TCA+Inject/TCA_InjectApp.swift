import AppFeature
import SwiftUI
import Inject

@main
struct TCA_InjectApp: App {
  @ObserveInjection var inject

    var body: some Scene {
        WindowGroup {
          AppView(store: .init(initialState: .init(), reducer: {
            AppReducer()
          }))
          .enableInjection()
        }
    }
}
