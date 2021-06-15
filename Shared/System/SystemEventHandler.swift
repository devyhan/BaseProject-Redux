//
//  SystemEventHandler.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/14.
//

import SwiftUI
import Combine

protocol SystemEventsHandler {
    func systemEventHandler_test()
}

// MARK: - Implementation

struct SystemEventsHandlerImpl: SystemEventsHandler {
    let container: DIContainer
    private var cancelBag = CancelBag()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func systemEventHandler_test() {
        print("systemEventHandler_test")
    }
}
