//: Playground - noun: a place where people can play

import Cocoa

//Swift高阶函数取代命令模式
//首先使用Swift实现一个经典的命令模式

// Receiver
class Light {
    
    func turnOn() {
        print("开灯")
    }
    
    func turnOff() {
        print("关灯")
    }
}

// Abstract Command
protocol Command {
    func execute()
}

// Concrete Command
class FlipUpCommand: Command {
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.turnOn()
    }
}

class FlipDownCommand: Command {
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.turnOff()
    }
}
//以上例程中，灯（Light）是命令（Command）的操作对象（Receiver）。我们定义了命令的协议，同时我们实现两个具体的命令操作：FlipUpCommand和FlipDownCommand。它们分别使灯亮，和使灯灭

//灯泡开关
class LightSwitch {
    
    var queue: [Command] = []
    
    func addCommand(command: Command) {
        queue.append(command)
    }
    
    func execute() {
        for command in queue {
            command.execute()
        }
    }
}

class People {
    
    static func pressSwitch() {
        let lamp = Light()
        let flipUpCommand = FlipUpCommand(light: lamp)
        let flipDownCommand = FlipDownCommand(light: lamp)
        
        let lightButton = LightSwitch()
        lightButton.addCommand(flipUpCommand)
        lightButton.addCommand(flipDownCommand)
        lightButton.addCommand(flipUpCommand)
        lightButton.addCommand(flipDownCommand)
        
        lightButton.execute()
    }
}

// Use
People.pressSwitch()

print("\n以下代码显示如何使用高阶函数达到命令模式相同的效果：\n")

class LightSwitchHF {
    
    var queue: Array<(Light) -> ()> = []
    
    func addCommand(command: (Light) -> ()) {
        queue.append(command)
    }
    
    func execute(light: Light) {
        for command in queue {
            command(light)
        }
    }
}

class PeopleHF {
    
    static func pressSwitch() {
        let lamp = Light()
        let flipUp = { (light: Light) -> () in light.turnOn() }
        let flipDown = { (light: Light) -> () in light.turnOff() }
        
        let lightSwitchFP = LightSwitchHF()
        lightSwitchFP.addCommand(flipUp)
        lightSwitchFP.addCommand(flipDown)
        lightSwitchFP.addCommand(flipUp)
        lightSwitchFP.addCommand(flipDown)
        
        lightSwitchFP.execute(lamp)
    }
}

// Use
PeopleHF.pressSwitch()



















