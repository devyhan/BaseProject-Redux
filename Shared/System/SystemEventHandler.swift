//
//  SystemEventHandler.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/14.
//

import SwiftUI
import Combine

// MARK: - Notifications

//private extension NotificationCenter {
//    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
//        let willShow = publisher(for: UIApplication.keyboardWillShowNotification)
//            .map { $0.keyboardHeight }
//        let willHide = publisher(for: UIApplication.keyboardWillHideNotification)
//            .map { _ in CGFloat(0) }
//        return Publishers.Merge(willShow, willHide)
//            .eraseToAnyPublisher()
//    }
//}
//
//private extension Notification {
//    var keyboardHeight: CGFloat {
//        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
//            .cgRectValue.height ?? 0
//    }
//}
