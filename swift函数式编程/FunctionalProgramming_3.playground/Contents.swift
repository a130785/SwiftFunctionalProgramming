//: Playground - noun: a place where people can play

import Cocoa

// Abstract Product
protocol Product {
    var brand: String { get }
    var name: String { get }
}

protocol Phone: Product { }

protocol Pad: Product { }

// Concrete Product
class ApplePhone: Phone {
    
    var brand: String {
        return "Apple"
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class SamsungPhone: Phone {
    
    var brand: String {
        return "Samsung"
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class ApplePad: Pad {
    
    var brand: String {
        return "Apple"
    }
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class SamsungPad: Pad {
    
    var brand: String {
        return "Samsung"
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

//然后，我们需要抽象工厂模式，来为创建这些同一主题的产品提供易于使用，方便扩展的方法：

// Abstract Factory
protocol AbstractFactory {
    func createPhone() -> Phone
    func createPad() -> Pad
}

// Concrete Factory
class AppleFactory: AbstractFactory {
    
    func createPhone() -> Phone {
        return ApplePhone(name: "iPhone 6S")
    }
    
    func createPad() -> Pad {
        return ApplePad(name: "iPad Air 2")
    }
}

class SamsungFactory: AbstractFactory {
    
    func createPhone() -> Phone {
        return SamsungPhone(name: "Note 5")
    }
    
    func createPad() -> Pad {
        return SamsungPad(name: "Note")
    }
}

//再看看如何使用抽象工厂：
let appleFactory: AbstractFactory = AppleFactory()
appleFactory.createPad().name

let samsungFactory: AbstractFactory = SamsungFactory()
samsungFactory.createPhone().name


/**
 *  对于这个抽象工厂实现来说，虽然加入一个新的设备类型会有很大问题，需要改变抽象工厂的接口，但如果只增加品牌就很好办了。只需在实现一个具体品牌的工厂即可。
 
 然后，我们使用柯里化函数来实现一个工厂方法。这个函数接受创建产品所需要各种参数，返回具体的产品。但我们实际上不会使用这个工厂方法直接创建产品。而是使用柯里化，让这个工厂方法充当一个函数工厂，创建一批可以作为产品工厂的方法。然后，我们可以使用这批产品工厂方法创建具体的产品。
 */

func createProductWithType(type: String, brand: String, name: String) -> Product? {
    switch (type, brand) {
    case ("Phone", "Apple"):
        return ApplePhone(name: name)
    case ("Pad", "Apple"):
        return ApplePad(name: name)
    case ("Phone", "Samsung"):
        return SamsungPhone(name: name)
    case ("Pad", "Samsung"):
        return SamsungPad(name: name)
    default:
        return nil
    }
}

let createApplePhone = createProductWithType("Phone",brand: "Apple",name: "iPhone 6S")

let createSamsungPhone = createProductWithType("Phone",brand: "Samsung",name: "Note 5")
let createApplePad = createProductWithType("Pad",brand: "Apple",name: "iPad Air 2")
let createSamsungPad = createProductWithType("Pad",brand: "Samsung",name: "Note")

// Use
print("\(createApplePhone!.name)")
print("\(createSamsungPhone!.name)")
