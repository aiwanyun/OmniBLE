//
//  PodProtocolError.swift
//  OmnipodKit
//
//  Created by Randall Knutson on 8/3/21.
//

import Foundation
import CoreBluetooth

enum PodProtocolError: Error {
    case invalidLTKKey(_ message: String)
    case pairingException(_ message: String)
    case messageIOException(_ message: String)
    case couldNotParseMessageException(_ message: String)
    case incorrectPacketException(_ payload: Data, _ location: Int)
    case invalidCrc(payloadCrc: Data, computedCrc: Data)
}

extension PodProtocolError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidLTKKey(let message):
            return String(format: LocalizedString("无效的 LTK 密钥：%1$@", comment: "The format string for PodProtocolError.invalidLTKKey (1: message associated with error)"), message)
        case .pairingException(let message):
            return String(format: LocalizedString("配对异常：%1$@", comment: "The format string for PodProtocolError.pairingException (1: message associated with error)"), message)
        case .messageIOException(let message):
            return String(format: LocalizedString("消息 IO 异常：%1$@", comment: "The format string for PodProtocolError.messageIOException (1: message associated with error)"), message)
        case .couldNotParseMessageException(let message):
            return String(format: LocalizedString("无法解析消息：%1$@", comment: "The format string for PodProtocolError.couldNotParseMessageException (1: message associated with error)"), message)
        case .incorrectPacketException(let payload, let location):
            let payloadStr = payload.hexadecimalString
            return String(format: LocalizedString("不正确的数据包异常：%1$@（位置=%2$d）", comment: "The format string for PodProtocolError.incorrectPacketException (1: payload)(2: location)"), payloadStr, location)
        case .invalidCrc(let payloadCrc, let computedCrc):
            return String(format: LocalizedString("有效负载 crc32 %1$@ 与计算出的 crc32 %2$@ 不匹配", comment: "The format string for description of PodProtocolError.invalidCrc (1:payload crc)(2:computed crc)"), payloadCrc.hexadecimalString, computedCrc.hexadecimalString)
        }
    }

    public var failureReason: String? {
        return nil
    }

    public var recoverySuggestion: String? {
        return nil
    }
}


