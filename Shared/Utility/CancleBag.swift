//
//  CancleBag.swift
//  BaseProject-Redux (iOS)
//
//  Created by ์กฐ์ํ on 2021/06/11.
//

import Combine

final class CancelBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    
    func cancel() {
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}

