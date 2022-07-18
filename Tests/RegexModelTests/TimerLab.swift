//
//  TimerLab.swift
//  RegexModel
//
//  Created by Secret Asian Man Dev on 17/7/22.
//

import XCTest
@testable import RegexModel

import RegexBuilder

final class TimerTests: XCTestCase {
    actor TimeoutChecker {
        var completed: Bool = false
        
        func markCompleted() -> Void {
            completed = true
        }
    }
    
    static let defaultTimeout: TimeInterval = 0.5
    
    /// Tests if a function is taking too long to execute.
    func helpTestTimeout(_ method: @escaping () -> Void) async throws {
        continueAfterFailure = false
        
        let checker = TimeoutChecker()
        
        /// Set flag is we complete in time.
        async let checkedTask = Task {
            method()
            await checker.markCompleted()
        }
        
        /// Check flag is set within time limit.
        /// - Note: `XCTAssert` must be on the main thread.
        async let timer = Task { @MainActor in
            try await Task.sleep(until: .now + .seconds(Self.defaultTimeout), clock: .continuous)
            let completed = await checker.completed
            XCTAssert(completed)
        }
        
        /// Set both tasks running concurrently.
        let _ = await (checkedTask.result, timer.result)
    }
}
