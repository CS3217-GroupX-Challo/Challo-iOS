//
//  FetchableRepository.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

protocol FetchableRepository {    
    func fetchAllAndRefresh(didRefresh: (() -> Void)?)
    func initialFetch(didFetch: (() -> Void)?)
}
