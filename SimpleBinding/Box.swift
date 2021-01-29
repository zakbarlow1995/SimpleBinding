//
//  Box.swift
//  SimpleBinding
//
//  Created by Zak Barlow on 04/02/2019.
//

import Foundation

/// A wrapper class for dynamic binding
class Box<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    /// Setup binding and fire with current Box\<T\>.value
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    /// Setup binding and await change to Box\<T\>.value before executing closure
    func bindAwait(listener: Listener?) {
        self.listener = listener
    }
    
}
