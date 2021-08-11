//
//  Logger.swift
//  RxMvvmTableView
//
//  Created by 김도희 on 2021/08/11.
//

import OSLog

final class Logger {

//    static let shared = Logger()
//
//    private init() { }

    /// OSLOG [DEBUG]
    static func d(_ message: String, _ category: OSLog = .default) {
        OSLog.log(message, log: category, type: .debug)
    }

    /// OSLOG [INFO]
    static func i(_ message: String, _ category: OSLog = .default) {
        OSLog.log(message, log: category, type: .info)
    }

    /// OSLOG [ERROR]
    static func e(_ message: String, _ category: OSLog = .default) {
        OSLog.log(message, log: category, type: .error)
    }

    /// OSLOG [FAULT]
    static func f(_ message: String, _ category: OSLog = .default) {
        OSLog.log(message, log: category, type: .fault)
    }

    /// OSLOG [DEFAULT]
    static func `default`(_ message: String, _ category: OSLog = .default) {
        OSLog.log(message, log: category, type: .default)
    }

}

extension OSLog {

    static func log(_ message: String, log: OSLog, type: OSLogType) {
        os_log("%@", log: log, type: type, message)
    }

    private static var subsystem = Bundle.main.bundleIdentifier!

    static let `default` = OSLog(subsystem: subsystem, category: "DEFAULT")
    static let ui = OSLog(subsystem: subsystem, category: "UI")
    static let network = OSLog(subsystem: subsystem, category: "NETWORK")

}
