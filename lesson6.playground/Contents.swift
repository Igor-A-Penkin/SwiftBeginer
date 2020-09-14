import UIKit

struct Queue<T: Car> {
    private var container: [T] = []
    
    mutating func push(object: T) {
        container.append(object)
        print("Object \(object) is added!")
    }
    mutating func pop() -> T? {
        print("Object \(container.first!) popped")
        return container.removeFirst()
    }
    
    let brandComparison: (String, String) -> Bool = { (brandName: String, brandNameOwned: String) -> Bool in
        return brandName == brandNameOwned
    }
    
    let assemblyDateComparison: (Date, Date) -> Bool = { (checkDate: Date, assemblyDate: Date) -> Bool in
        return checkDate == assemblyDate
    }
    
    func filterByBrand(filter: String, predicate: (String, String) -> Bool) -> [T] {
        var array = [T]()
        for object in container {
            if predicate(filter, object.brand) {
                array.append(object)
            }
        }
        return array
    }
    
    func filterByAssemblyDate(filter: Date, predicate: (Date, Date) -> Bool) -> [T] {
        var array = [T]()
        for object in container {
            if predicate(filter, object.assemblyDate) {
                array.append(object)
            }
        }
        return array
    }
    
    subscript(index: UInt) -> T? {
        guard index < container.count else { return nil }
        return container[Int(index)]
    }
}


// Ниже наследие Урока No.5 в котором реализована логика самих объектов которые будем
// помещать в очередь Queue
//
// А в самом конце проверка к Уроку No.6
protocol Car {
    var brand: String { get set }
    var model: String { get set }
    var assemblyDate: Date { get set }
    var trunkVolume: Double { get set }
    var trunkFilledVolume: Double { get set }
    var engine: engineModifier { get set }
    var window: windowModifier { get set }
    var trunkFreeSpace: Double { get set }
    
    func showSpecification()
    func turnCover()
    func useSpecialAbility()
}

extension Car {
    mutating func operateTrunk(trunkModifier: trunkModifier, luggage: Double) {
        switch trunkModifier {
        case .loadIn:
            if self.trunkFilledVolume+luggage<trunkVolume {
                self.trunkFilledVolume += luggage
                print("Your luggage has been successfully loaded in!")
            } else {
                print("Fail: your luggage is too huge! Total trunk volume is \(trunkVolume.rounded())")
            }
        case .loadOut:
            if self.trunkFilledVolume-luggage>=0 {
                self.trunkFilledVolume -= luggage
                print("Your luggage has been successfully loaded out!")
            } else {
                print("Fail: there is no so much luggage! Here is only \(trunkFilledVolume.rounded())")
            }
        }
    }
    
    mutating func turnEngine(engineModifier: engineModifier) {
        engine = engineModifier
        print(engine.rawValue)
    }
    
    mutating func turnWindow(windowModifier: windowModifier) {
        window = windowModifier
        print(window.rawValue)
    }
}

enum engineModifier: String {
    case on = "Engine started!"
    case off = "Engine stopped!"
    
    func turnEngine() -> engineModifier {
        switch self {
        case .on:
            print(engineModifier.off.rawValue)
            return engineModifier.off
        case .off:
            print(engineModifier.on.rawValue)
            return engineModifier.on
        }
    }
}

enum windowModifier: String {
    case up = "Windows upped!"
    case down = "Windows downed!"
    
    func turnWindow() -> windowModifier {
        switch self {
        case .up:
            print(windowModifier.down.rawValue)
            return windowModifier.down
        case .down:
            print(windowModifier.up.rawValue)
            return windowModifier.up
        }
    }
}

enum trunkModifier {
    case loadIn
    case loadOut
}


class SportCar: Car {
    var brand: String
    var model: String
    var assemblyDate: Date
    var trunkVolume: Double
    var trunkFilledVolume: Double
    var engine: engineModifier
    var window: windowModifier
    var trunkFreeSpace: Double
    
    static var limitedNumber: UInt8 = 0
    
    private(set) var turboBoost: Bool
    private(set) var limitedEdition: Bool
    private(set) var cover: coverModifier
    private(set) var turbo: turboModifier
    let VIN: Int = Int(Double.random(in: 1000000.0...9999999.0))
    
    enum coverModifier: String {
        case open = "Roof opened!"
        case cover = "Roof covered!"
        
        func turnCover() -> coverModifier {
            switch self {
            case .open:
                print(coverModifier.cover.rawValue)
                return coverModifier.cover
            case .cover:
                print(coverModifier.open.rawValue)
                return coverModifier.open
            }
        }
    }
    
    enum turboModifier: String {
        case on = "Turbo acceleration is ON!"
        case off = "Turbo acceleration is OFF!"
        
        func turnTurbo() -> turboModifier {
            switch self {
            case .on:
                print(turboModifier.off.rawValue)
                return turboModifier.off
            case .off:
                print(turboModifier.on.rawValue)
                return turboModifier.on
            }
        }
    }
    
    init( brand: String, model: String, assemblyDate: Date, trunkVolume: Double, turboBoost: Bool, limitedEdition: Bool) {
        self.brand = brand
        self.model = model
        self.assemblyDate = assemblyDate
        self.trunkVolume = trunkVolume
        self.trunkFilledVolume = 0.0
        self.trunkFreeSpace = trunkVolume
        self.engine = engineModifier.off
        self.window = windowModifier.up
        self.turboBoost = turboBoost
        self.limitedEdition = limitedEdition
        self.cover = coverModifier.cover
        self.turbo = turboModifier.off
        
        if self.limitedEdition && SportCar.limitedNumber<=100 {
            SportCar.limitedNumber += 1
        } else if SportCar.limitedNumber>100 {
            print("Unfortunately, limited series is over!")
            self.limitedEdition = false
        }
    }
    
    func showSpecification() {
        print("============= SPECIFICATION ==============")
        print("Brand name: \(brand)")
        print("Model: \(model)")
        print("Assembly date: \(assemblyDate)")
        print("Volume of trunk: \(trunkVolume)")
        print("Free space of trunk: \(trunkFreeSpace)")
        print("Engine status: \(engine)")
        print("Windows status: \(window)")
        print("Cabrio roof status: \(cover)")
        print("Special ability in stock: \(turboBoost)")
        if limitedEdition {
            print("Limited number #: \(SportCar.limitedNumber)")
        }
        print("==========================================")
    }
    
    func turnCover() {
        cover = cover.turnCover()
    }
    
    func useSpecialAbility() {
        if self.turboBoost {
            turbo.turnTurbo()
        } else {
            print("Fail: you had to choose more expensive configuration buying your car :(")
        }
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "VIN: \(VIN)"
    }
}

class TrunkCar: Car {
    var brand: String
    var model: String
    var assemblyDate: Date
    var trunkVolume: Double
    var trunkFilledVolume: Double
    var engine: engineModifier
    var window: windowModifier
    var trunkFreeSpace: Double
    
    private(set) var allWheelDrive: Bool
    private(set) var cover: coverModifier
    private(set) var AWD: AWDModifier
    let engineSN: Int = Int(Double.random(in: 1000000.0...9999999.0))
    let frameSN: Int = Int(Double.random(in: 1000000.0...9999999.0))
    
    enum coverModifier: String {
        case open = "Bodywork opened!"
        case cover = "Bodywork body covered!"
        
        func turnCover() -> coverModifier {
            switch self {
            case .open:
                print(coverModifier.cover.rawValue)
                return coverModifier.cover
            case .cover:
                print(coverModifier.open.rawValue)
                return coverModifier.open
            }
        }
    }
    
    enum AWDModifier: String {
        case on = "AWD mode is ON!"
        case off = "AWD mode is OFF!"
        
        func turnAWD() -> AWDModifier {
            switch self {
            case .on:
                print(AWDModifier.off.rawValue)
                return AWDModifier.off
            case .off:
                print(AWDModifier.on.rawValue)
                return AWDModifier.on
            }
        }
    }
    
    init(brand: String, model: String, assemblyDate: Date, trunkVolume: Double, allWheelDrive: Bool) {
        self.allWheelDrive = allWheelDrive
        self.cover = coverModifier.cover
        self.AWD = AWDModifier.off
        self.brand = brand
        self.model = model
        self.assemblyDate = assemblyDate
        self.trunkVolume = trunkVolume
        self.trunkFilledVolume = 0.0
        self.trunkFreeSpace = trunkVolume
        self.engine = engineModifier.off
        self.window = windowModifier.up
    }
    
    func showSpecification() {
        print("============= SPECIFICATION ==============")
        print("Brand name: \(brand)")
        print("Model: \(model)")
        print("Assembly date: \(assemblyDate)")
        print("Volume of trunk: \(trunkVolume)")
        print("Free space of trunk: \(trunkFreeSpace)")
        print("Engine status: \(engine)")
        print("Windows status: \(window)")
        print("Bodywork status: \(cover)")
        print("Special ability in stock: \(allWheelDrive)")
        print("==========================================")
    }
    
    func turnCover() {
        cover = cover.turnCover()
    }
    
    func useSpecialAbility() {
        if self.allWheelDrive {
            AWD.turnAWD()
        } else {
            print("Fail: you had to choose more expensive configuration buying your car :(")
        }
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Engine S/N: \(engineSN), Frame S/N: \(frameSN)"
    }
}


// ПРОВЕРКА НА ПРИМЕРЕ КЛАССА SPORTCAR
//
//var mazda6 = SportCar(brand: "Mazda", model: "6", assemblyDate: Date(), trunkVolume: 440.0, turboBoost: false, limitedEdition: false)
//var audiA7 = SportCar(brand: "Audi", model: "A7", assemblyDate: Date(), trunkVolume: 375.0, turboBoost: true, limitedEdition: false)
//var bmwM5 = SportCar(brand: "BMW", model: "M5", assemblyDate: Date(), trunkVolume: 397.0, turboBoost: true, limitedEdition: true)
//var sportCarQueue = Queue<SportCar>()
//
//sportCarQueue.push(object: mazda6)
//sportCarQueue.push(object: audiA7)
//sportCarQueue.push(object: bmwM5)
//
//print(sportCarQueue[5])
//print(sportCarQueue[1])
//
//sportCarQueue.filterByBrand(filter: "Mazda", predicate: sportCarQueue.brandComparison)
