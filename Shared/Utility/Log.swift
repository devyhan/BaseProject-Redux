//
//  Log.swift
//  BaseProject-Redux (iOS)
//
//  Created by ์กฐ์ํ on 2021/06/15.
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
        case .debug: print("ใ๐ข DEBUGใใ\(currentTime)msใใ\(fileName):\(line): \(function)ใ : " + "\(message)")
        case .network: print("ใ๐  NETWORKใใ\(currentTime)msใใ\(fileName):\(line): \(function)ใ : " + "\(message)")
        case .error: print("ใ๐ด ERRORใใ\(currentTime)msใใ\(fileName):\(line): \(function)ใ : " + "\(message)")
        }
    }
}
