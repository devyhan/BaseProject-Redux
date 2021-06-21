//
//  Log.swift
//  BaseProject-Redux (iOS)
//
//  Created by 조요한 on 2021/06/15.
//

import Foundation

final class Log {
    enum LogType {
        case debug
        case network
        case error
    }
    
    @discardableResult
    init(type: LogType, _ message: Any, withPath: Bool = false, file: String = #file, function: String = #function, line: UInt = #line) {
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "HH:mm:ss SSS"
        let currentTime = formatterTime.string(from: Date())
        var fileName: String = file
        if (!withPath) {
            if let i = fileName.lastIndex(of: "/") {
                fileName = String(file[fileName.index(i, offsetBy: 1)...])
            }
        }
        
        switch type {
        case .debug: print("〈🟢 DEBUG〉〈\(currentTime)ms〉〈\(fileName):\(line): \(function)〉 : " + "\(message)")
        case .network: print("〈🟠 NETWORK〉〈\(currentTime)ms〉〈\(fileName):\(line): \(function)〉 : " + "\(message)")
        case .error: print("〈🔴 ERROR〉〈\(currentTime)ms〉〈\(fileName):\(line): \(function)〉 : " + "\(message)")
        }
    }
}
