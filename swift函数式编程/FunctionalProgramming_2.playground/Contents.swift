//: Playground - noun: a place where people can play

import Cocoa

//先用Swift实现传统的策略模式：

protocol Strategy {
    func compute(first: Int, second: Int) -> Int
}

class Add: Strategy {
    func compute(first: Int, second: Int) -> Int {
        return first + second
    }
}

class Multiply: Strategy {
    func compute(first: Int, second: Int) -> Int {
        return first * second
    }
}

class Context {
    let strategy: Strategy
    
    init(strategy: Strategy) {
        self.strategy = strategy
    }
    
    func use(first: Int, second: Int) {
        strategy.compute(first, second: second)
    }
}

let context = Context(strategy: Add())
let context1 = Context(strategy: Multiply())
context.use(1, second: 2)
context1.use(1, second: 2)

//然后我们再看看如果存在一等函数，策略模式是否可以得到化简：
let add = { (first: Int, second: Int) -> Int in
    return first + second
}

let multiply = { (first: Int, second: Int) -> Int in
    return first * second
}

class ContextFP {
    
    let strategy: (Int, Int) -> Int
    
    init(strategy: (Int, Int) -> Int) {
        self.strategy = strategy
    }
    
    func use(first: Int, second: Int) {
        strategy(first, second)
    }
}

let fpContext = ContextFP(strategy: multiply)
let fpContext1 = ContextFP(strategy: add)
fpContext.use(1, second:2)
fpContext1.use(1, second:2)











