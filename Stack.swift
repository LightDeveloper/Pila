//
//  Stack.swift
//  Pila
//
//  Created by Dev2 on 25/04/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

protocol StackDelegate {
    func stack<Item>(_ stack: Stack<Item>, pushedItem item: Item)
    func stack<Item>(_ stack: Stack<Item>, popedItem item: Item)
}

struct Stack<Item> {
    private var items: [Item] = []
    
    var pushedItem: ( (Item) -> () )?
    
//    weak var delegate: StackDelegate?
    
    mutating func push(item: Item) {
        items.append(item)
        if let pushedItemUnwrapped = pushedItem {
            pushedItemUnwrapped(item)
        }
        
//        delegate?.stack(self, pushedItem: item)
    }
    
    @discardableResult
    mutating func pop() -> Item? {
        if items.isEmpty {
            return nil
        }
        let itemPopped = items.removeLast()
//        delegate?.stack(self, popedItem: itemPopped)
        return itemPopped
    }
}

extension Stack {
    var head: Item? {
        return items.last
    }
    
    var count: Int {
        return items.count
    }
}
