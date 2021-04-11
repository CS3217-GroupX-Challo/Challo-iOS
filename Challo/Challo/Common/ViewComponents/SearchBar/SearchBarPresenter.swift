//
//  SearchBarPresenter.swift
//  Challo
//
//  Created by Shao Yi on 11/4/21.
//

import Foundation

protocol SearchBarPresenter: PresenterProtocol {
    var searchBarText: String { get set }
    var isSearchBarSheetOpen: Bool { get set }
}
