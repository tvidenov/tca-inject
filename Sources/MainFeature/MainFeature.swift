import ComposableArchitecture
import Inject
import SwiftUI

@Reducer
public struct MainFeature {
  @ObservableState
  public struct State: Equatable {
    var count = 0

    public init() {}
  }

  public enum Action {
    case decrementButtonTapped
    case incrementButtonTapped
  }

  public init() {}

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .decrementButtonTapped:
        state.count -= 1
        return .none
      case .incrementButtonTapped:
        state.count += 1
        return .none
      }
    }
  }
}

// MARK: - Feature view

public struct MainFeatureView: View {
  @ObserveInjection var inject
  let store: StoreOf<MainFeature>

  public init(store: StoreOf<MainFeature>) {
    self.store = store
  }

  public var body: some View {
    HStack {
      Button {
        store.send(.decrementButtonTapped)
      } label: {
        Image(systemName: "minus")
      }

      Text("\(store.count)")
        .monospacedDigit()

      Button {
        store.send(.incrementButtonTapped)
      } label: {
        Image(systemName: "plus")
      }
    }.enableInjection()
  }
}
