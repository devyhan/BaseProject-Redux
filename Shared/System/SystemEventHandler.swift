//
//  SystemEventHandler.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/14.
//

import SwiftUI
import Combine
import Firebase
import FirebaseRemoteConfig


protocol SystemEventsHandler {
    func firebaseConfigure()
    func getRemoteConfigure()
    func systemEventHandler_test()
    func onAppEnterForground_test()
    func onAppEnteredBackground_test()
}

// MARK: - Implementation

struct SystemEventsHandlerImpl: SystemEventsHandler {
    let container: DIContainer
//    let remoteConfig: RemoteConfig
    private var cancelBag = CancelBag()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func firebaseConfigure() {
        FirebaseApp.configure()
        RemoteConfig.remoteConfig()
    }
    
    func getRemoteConfigure() {
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetch() { (status, error) -> Void in
            if status == .success {
              print("Config fetched!")
              let ver = remoteConfig["application_version_requierd"].stringValue!
              Log(type: .debug, ver)
            } else {
              print("Config not fetched")
              print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
  //          self.displayWelcome()
          }
        
        
//        remoteConfig.fetch() { (status, error) -> Void in
//          if status == .success {
//            print("Config fetched!")
//            let ver = remoteConfig["application_version_requierd"].stringValue!
//            Log(type: .debug, ver)
//          } else {
//            print("Config not fetched")
//            print("Error: \(error?.localizedDescription ?? "No error available.")")
//          }
//          self.displayWelcome()
//        }
//        let subject = PassthroughSubject<Void, Error>()
        
//        remoteConfig.fetch { (status, error) in
//            switch status {
//            case .success:
//                remoteConfig.activate { (changed, error) in
//                    if let e = error {
//                        subject.send(completion: .failure(e))
//                    } else {
//                        subject.send()
//                    }
//                }
//            case .noFetchYet, .failure, .throttled:
//                if let e = error {
//                    subject.send(completion: .failure(e))
//                } else {
//                    subject.send(completion: .failure(ThrowableError.unknown(message: "FIRRemoteConfigFetchStatus : \(status)")))
//                }
//            @unknown default:
//                #warning("Error handling is required")
//                fatalError("An unknown status was returned fetch while FirebaseRemoteConfig")
//            }
//        }
        

//        Log(type: .debug, subject)
    }
    
    func systemEventHandler_test() {
        Log(type: .debug, "test_system_log")
    }
    
    func onAppEnterForground_test() {
        Log(type: .debug, "onAppEnterForground")
        container.appState[\.system.isActive] = false
    }
    
    func onAppEnteredBackground_test() {
        Log(type: .debug, "onAppEnteredBackground")
        container.appState[\.system.isActive] = true
    }
    
//    private func getVariantObj<R: Codable>(_ key: String) -> R? {
//        let config: Dictionary<String, R>? = self.remoteConfig
//            .configValue(forKey: key).dataValue.fromJson()
//        return config?[Config.flavor.lowercased()]
//    }
}

extension Bundle {
    static var appVersion: String {
        if let value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String { return value }
        return ""
    }
}

class Config {
    #if DEBUG
    static let isDebug = true
    #else
    static let isDebug = false
    #endif
}

enum ThrowableError: Error {
    case nilPointer
    case unknown(message: String)
}
