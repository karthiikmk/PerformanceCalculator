//
//  PthreadMutex.swift
//  PerformanceCalculator
//
//  Created by Karthik on 11/02/22.
//

import Foundation
import SwiftStandardLibraryKit

public struct PthreadMutexLock<Value> {
    private let mutex = PThreadMutex()
    private var _value: Value
    
    public init(_ value: Value) {
        self._value = value
    }
    
    public var value: Value {
        return mutex.withCriticalScope {
            return _value
        }
    }
    
    public mutating func value(execute task: (inout Value) -> Void) {
        mutex.withCriticalScope { task(&_value) }
    }
}
