//
//  LoadableEntityPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

/// A base presenter that encapsulates loading states
///
/// `onRefresh` is an abstract method that must be overriden and implemented by subclasses
class LoadableEntityPresenter: LoadablePresenter, ObservableObject {
    var isFirstLoad = true
    @Published var isLoading = false
    @Published var isRefreshing = false {
        didSet {
            refresh()
        }
    }
    
    // swiftlint:disable unavailable_function
    func onRefresh() {
        fatalError("onRefresh is not implemented")
    }
}
