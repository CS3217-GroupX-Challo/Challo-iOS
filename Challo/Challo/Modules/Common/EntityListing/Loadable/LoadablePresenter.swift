//
//  LoadablePresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

protocol LoadablePresenter {
    var isFirstLoad: Bool { get set }
    var isLoading: Bool { get set }
    var isRefreshing: Bool { get set }
    
    func onRefresh()
}

extension LoadablePresenter {
    func refresh() {
        if isRefreshing {
            onRefresh()
        }
    }
}
