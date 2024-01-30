import SwiftUI
import MainFeature
import SecondFeature
import ComposableArchitecture
import Inject

public enum Tab: Int, RawRepresentable {
  case main = 0
  case second = 1
}

@Reducer
public struct AppReducer {
  @ObservableState
  public struct State: Equatable {
    var mainFeature = MainFeature.State()
    var secondFeature = SecondFeature.State()
    var selectedTab: Tab = .main

    public init() {}
  }

  public enum Action {
    case mainFeature(MainFeature.Action)
    case secondFeature(SecondFeature.Action)
    case selectedTabChanged(Tab)
  }

  public init() {}

  public var body: some ReducerOf<AppReducer> {
    Reduce<State, Action> { state, action in
      switch action {
      case let .selectedTabChanged(tab):
        if state.selectedTab == tab {
          switch tab {
          case .main:
            return .none
          case .second:
            return .none
          }
        }
        state.selectedTab = tab
        return .none
      case .mainFeature, .secondFeature:
        return .none
      }
    }
    Scope(state: \.mainFeature, action: \.mainFeature) {
      MainFeature()
    }
    Scope(state: \.secondFeature, action: \.secondFeature) {
      SecondFeature()
    }
  }
}

public struct AppView: View {
  @ObserveInjection var inject
  @Bindable var store: StoreOf<AppReducer>

  public init(store: StoreOf<AppReducer>) {
    self.store = store
  }

  public var body: some View {
    TabView(selection: $store.selectedTab.sending(\.selectedTabChanged)) {
        NavigationStack {
          MainFeatureView(
            store: store.scope(state: \.mainFeature, action: \.mainFeature)
          )
        }
        .navigationViewStyle(.stack)
        .tabItem {
          Image(systemName: "plusminus")
        }
        .tag(Tab.main)

        NavigationStack {
          SecondFeatureView(
            store: store.scope(state: \.secondFeature, action: \.secondFeature)
          )
        }
        .navigationViewStyle(.stack)
        .tabItem {
          Image(systemName: "clock")
        }
        .tag(Tab.second)
      }.enableInjection()
  }
}
