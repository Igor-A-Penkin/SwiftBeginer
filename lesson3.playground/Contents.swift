import Cocoa

struct SportCar {
    private var brand:              String
    private var model:              String
    private var assemblyDate:       Date
    private var trunkVolume:        Double
    private var trunkFilledVolume:  Double
    private var engine:             engineModifier
    private var window:             windowModifier
    private var trunkFreeSpace:     Double {
        get {
            return trunkVolume-trunkFilledVolume
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
    
    init( brand:              String,
          model:              String,
          assemblyDate:       Date,
          trunkVolume:        Double
    ) {
        self.brand = brand
        self.model = model
        self.assemblyDate = assemblyDate
        self.trunkVolume = trunkVolume
        self.trunkFilledVolume = 0.0
        self.engine = engineModifier.off
        self.window = windowModifier.up
    }
    
    mutating func operateTrunk(trunkModifier: trunkModifier, luggage: Double) {
        switch trunkModifier {
        case .loadIn:
            if self.trunkFilledVolume+luggage<trunkVolume {
                self.trunkFilledVolume += luggage
                print("Your luggage has been successfully loaded in!")
            } else {
               print("Fail: your luggage is too huge! Total trunk volume is \(trunkVolume)")
            }
        case .loadOut:
            if self.trunkFilledVolume-luggage>=0 {
                self.trunkFilledVolume -= luggage
                print("Your luggage has been successfully loaded out!")
            } else {
               print("Fail: there is no so much luggage! Here is only \(trunkFilledVolume)")
            }
        }
    }
    
    mutating func turnEngine() {
        engine = engine.turnEngine()
    }
    
    mutating func turnEngine(engineModifier: engineModifier) {
        engine = engineModifier
        print(engine.rawValue)
    }
    
    mutating func turnWindow() {
        window = window.turnWindow()
    }
    
    mutating func turnWindow(windowModifier: windowModifier) {
        window = windowModifier
        print(window.rawValue)
    }
    
    func showSportCar() {
        print("============= SPORTCAR INFO =============")
        print("Brand name: \(brand)")
        print("Model: \(model)")
        print("Assembly date: \(assemblyDate)")
        print("Volume of trunk: \(trunkVolume)")
        print("Free space of trunk: \(trunkFreeSpace)")
        print("Engine status: \(engine)")
        print("Windows status: \(window)")
        print("=========================================")
    }
}

// MAIN

var mazda6 = SportCar(brand: "Mazda", model: "6", assemblyDate: Date(), trunkVolume: 440.0)
var auduA7 = SportCar(brand: "Audi", model: "A7", assemblyDate: Date(), trunkVolume: 375.0)
var bmwM5 = SportCar(brand: "BMW", model: "M5", assemblyDate: Date(), trunkVolume: 397.0)
var sportCars: [SportCar] = [mazda6, auduA7, bmwM5]

for car in 0..<sportCars.count {
    sportCars[car].showSportCar()
    print("")
    sportCars[car].turnEngine()
    sportCars[car].turnEngine(engineModifier: .off)
    sportCars[car].turnWindow()
    sportCars[car].turnWindow(windowModifier: .up)
    sportCars[car].operateTrunk(trunkModifier: .loadIn, luggage: Double.random(in: 1.0...400.0))
    sportCars[car].operateTrunk(trunkModifier: .loadIn, luggage: Double.random(in: 1.0...400.0))
    sportCars[car].operateTrunk(trunkModifier: .loadOut, luggage: Double.random(in: 1.0...400.0))
    sportCars[car].operateTrunk(trunkModifier: .loadOut, luggage: Double.random(in: 1.0...400.0))
    print("")
}



//  Вторая структура для грузовика, но там по сути все тоже самое, по логике их нужно
//  было делать через классы с наследованием от класса "транспорт"
struct TruckCar {
    private var brand:              String
    private var model:              String
    private var assemblyDate:       Date
    private var trunkVolume:        Double
    private var trunkFilledVolume:  Double
    private var engine:             engineModifier
    private var window:             windowModifier
    private var trunkFreeSpace:     Double {
        get {
            return trunkVolume-trunkFilledVolume
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
    
    init( brand:              String,
          model:              String,
          assemblyDate:       Date,
          trunkVolume:        Double
    ) {
        self.brand = brand
        self.model = model
        self.assemblyDate = assemblyDate
        self.trunkVolume = trunkVolume
        self.trunkFilledVolume = 0.0
        self.engine = engineModifier.off
        self.window = windowModifier.up
    }
    
    mutating func operateTrunk(trunkModifier: trunkModifier, luggage: Double) {
        switch trunkModifier {
        case .loadIn:
            if self.trunkFilledVolume+luggage<trunkVolume {
                self.trunkFilledVolume += luggage
                print("Your luggage has been successfully loaded in!")
            } else {
               print("Fail: your luggage is too huge! Total trunk volume is \(trunkVolume)")
            }
        case .loadOut:
            if self.trunkFilledVolume-luggage>=0 {
                self.trunkFilledVolume -= luggage
                print("Your luggage has been successfully loaded out!")
            } else {
               print("Fail: there is no so much luggage! Here is only \(trunkFilledVolume)")
            }
        }
    }
    
    mutating func turnEngine() {
        engine = engine.turnEngine()
    }
    
    mutating func turnEngine(engineModifier: engineModifier) {
        engine = engineModifier
        print(engine.rawValue)
    }
    
    mutating func turnWindow() {
        window = window.turnWindow()
    }
    
    mutating func turnWindow(windowModifier: windowModifier) {
        window = windowModifier
        print(window.rawValue)
    }
    
    func showSportCar() {
        print("============= TRUCKCAR INFO =============")
        print("Brand name: \(brand)")
        print("Model: \(model)")
        print("Assembly date: \(assemblyDate)")
        print("Volume of trunk: \(trunkVolume)")
        print("Free space of trunk: \(trunkFreeSpace)")
        print("Engine status: \(engine)")
        print("Windows status: \(window)")
        print("=========================================")
    }
}
