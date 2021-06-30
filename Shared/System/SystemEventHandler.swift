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
    func getRemoteConfigure()
    func systemEventHandler_test()
    func onAppEnterForground_test()
    func onAppEnteredBackground_test()
}

// MARK: - Implementation

struct SystemEventsHandlerImpl: SystemEventsHandler {
    let container: DIContainer
    private var cancelBag = CancelBag()
    private var remoteConfig: RemoteConfig
    
    init(container: DIContainer) {
        self.container = container
        
        // Firebase
        FirebaseApp.configure()
        self.remoteConfig = RemoteConfig.remoteConfig()
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = AppEnvironment.isDebug ? 0 : (5 * 60)
        remoteConfig.configSettings = setting
    }
    
    func getRemoteConfigure() {
        remoteConfig.fetch() { (status, error) -> Void in
            if status == .success {
                remoteConfig.activate() { (changed, error) in
                    guard let requierdVersion: String = getVariantObj("application_version_requierd") else { return }
                    guard let optionalVersion: String = getVariantObj("application_version_optional") else { return }
                    guard let baseURL: String = getVariantObj("base_url") else { return }
                    guard let APIKey: String = getVariantObj("api_key") else { return }
                    
                    Log(type: .network, requierdVersion)
                    Log(type: .network, optionalVersion)
                    Log(type: .network, baseURL)
                    Log(type: .network, APIKey)
                    
                    container.appState[\.system.requierdVersion] = requierdVersion
                    container.appState[\.system.optionalVersion] = optionalVersion
                    container.appState[\.system.baseURL] = baseURL
                    container.appState[\.system.APIKey] = APIKey
                }
            } else {
                Log(type: .error, "Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
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
    
    private func getVariantObj<R: Codable>(_ key: String) -> R? {
        let config: Dictionary<String, R>? = remoteConfig
            .configValue(forKey: key).dataValue.fromJson()
        return config?[AppEnvironment.flavor.lowercased()]
    }
}

extension Bundle {
    static var appVersion: String {
        if let value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String { return value }
        return ""
    }
}

extension Data {
    func fromJson<T: Codable>() -> T {
        Log(type: .debug, T.self)
        return try! JSONDecoder().decode(T.self, from: self)
    }
}

enum ThrowableError: Error {
    case nilPointer
    case unknown(message: String)
}
