import UIKit

// READ ME BELOW
// Добавлен enum operationError с перечислением возможных ошибок.
// Метод operateTrunk() в расширении пртокола Car, метод useSpecialAbility() в классах SportCar и TrunkCar пепеписаны, теперь они могут возвращать ошибки.
// В классы SportCar и TrunkCar внесены изменения для возможости обработки ошибок (исключений):
// добавлена структура CarOwner хранящая информацию о владельце,
// добавлена структура DriverRequirements хранящая информацию о требованиях к водителю:
// - владелец может взаимдействовать с окнами, багажником, и т.д.,
// - владелец не соответствующий хотя бы одному требованию водителя не может запускать/глушить двигатель, вызывать службу помощи на дороге.

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
        guard index < container.count && container.count != 0 else { return nil }
        return container[Int(index)]
    }
}

protocol Car {
    var brand: String { get set }
    var model: String { get set }
    var assemblyDate: Date { get set }
    var trunkVolume: Double { get set }
    var trunkFilledVolume: Double { get set }
    var engine: engineModifier { get set }
    var window: windowModifier { get set }
    var trunkFreeSpace: Double { get set }
    var carOwners: [String: CarOwner]? { get set }
    var driverRequirements: DriverRequirements { get set }
    
    func showSpecification()
    func turnCover()
    func useSpecialAbility() -> operationError?
}

extension Car {
    mutating func operateTrunk(trunkModifier: trunkModifier, luggage: Double) -> operationError? {
        switch trunkModifier {
        case .loadIn:
            guard trunkFilledVolume+luggage<=trunkVolume else {
                //print("Fail: your luggage is too huge!")
                return operationError.tooHugeLuggage(excessiveVolume: trunkFilledVolume+luggage-trunkVolume)
            }
            self.trunkFilledVolume += luggage
            print("Your luggage has been successfully loaded in!")
            return nil
        case .loadOut:
            guard trunkFilledVolume-luggage>=0 else {
                //print("Fail: there is no so much luggage!")
                return operationError.notEnoughLuggage(filledVolume: trunkFilledVolume)
            }
            self.trunkFilledVolume -= luggage
            print("Your luggage has been successfully loaded out!")
            return nil
        }
    }
    
    mutating func turnEngine(engineModifier: engineModifier, carOwner: CarOwner) throws {
        guard driverValidation(carOwner: carOwner) == nil else {
            throw driverValidation(carOwner: carOwner)!
        }
        
        engine = engineModifier
        print(engine.rawValue)
    }
    
    mutating func turnWindow(windowModifier: windowModifier) {
        window = windowModifier
        print(window.rawValue)
    }
    
    func driverValidation(carOwner: CarOwner) -> operationError? {
        guard carOwner.validDrivingLicense == driverRequirements.validDrivingLicense else {
            return operationError.accessDenied
        }
        guard carOwner.vehilceCategory?.contains(driverRequirements.requiredCategory) ?? false else {
            return operationError.accessDenied
        }
        guard carOwner.yearsOld >= driverRequirements.yearsOld ?? 0 else {
            return operationError.accessDenied
        }
        guard carOwner.expierenceInYear ?? 0 >= driverRequirements.requiredExperienceInYear ?? 0 else {
            return operationError.accessDenied
        }
        return nil
    }
}

enum operationError: Error {
    case tooHugeLuggage(excessiveVolume: Double)
    case notEnoughLuggage(filledVolume: Double)
    case missingSpeciaAbility
    case accessDenied
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

struct CarOwner {
    var name: String
    var surname: String
    var yearsOld: Int
    var validDrivingLicense: Bool
    var vehilceCategory: [String]?
    var expierenceInYear: Int?
}

struct DriverRequirements {
    var yearsOld: Int?
    var validDrivingLicense: Bool?
    var requiredExperienceInYear: Int?
    var requiredCategory: String
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
    var carOwners: [String: CarOwner]?
    var driverRequirements: DriverRequirements
    
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
    
    init(brand: String, model: String, assemblyDate: Date, trunkVolume: Double, turboBoost: Bool, limitedEdition: Bool, carOwners: [String: CarOwner], driverRequirements: DriverRequirements) {
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
        self.carOwners = carOwners
        self.driverRequirements = driverRequirements
        
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
    
    func callRoadHelp(carOwner: CarOwner) throws {
        guard driverValidation(carOwner: carOwner) == nil else {
            throw driverValidation(carOwner: carOwner)!
        }
        
        print("Calling Road help for evacuator...")
    }
    
    func useSpecialAbility() -> operationError? {
        guard turboBoost else {
            //print("Fail: you had to choose more expensive configuration buying your car :(")
            return operationError.missingSpeciaAbility
        }
        
        turbo.turnTurbo()
        return nil
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
    var carOwners: [String: CarOwner]?
    var driverRequirements: DriverRequirements
    
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
    
    init(brand: String, model: String, assemblyDate: Date, trunkVolume: Double, allWheelDrive: Bool, carOwners: [String: CarOwner], driverRequirements: DriverRequirements) {
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
        self.carOwners = carOwners
        self.driverRequirements = driverRequirements
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
    
    func useSpecialAbility() -> operationError? {
        guard allWheelDrive else {
            //print("Fail: you had to choose more expensive configuration buying your car :(")
            return operationError.missingSpeciaAbility
        }
        
        AWD.turnAWD()
        return nil
    }
    
    func callRoadHelp(carOwner: CarOwner) throws {
        guard driverValidation(carOwner: carOwner) == nil else {
            throw driverValidation(carOwner: carOwner)!
        }
        
        print("Calling Road help for tractive unit...")
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Engine S/N: \(engineSN), Frame S/N: \(frameSN)"
    }
}


var carOwners = [
    "Dad": CarOwner(name: "John", surname: "Johnson", yearsOld: 42, validDrivingLicense: true, vehilceCategory: ["A", "B", "B1", "C", "M"], expierenceInYear: 24),
    "Son": CarOwner(name: "Sam", surname: "Johnson", yearsOld: 23, validDrivingLicense: true, vehilceCategory: ["A", "M"], expierenceInYear: 5),
    "Daughter": CarOwner(name: "Lilly", surname: "Johnson", yearsOld: 17, validDrivingLicense: true, vehilceCategory: ["A", "B", "B1", "M"], expierenceInYear: 1),
    "Mom": CarOwner(name: "Sarha", surname: "Spencer", yearsOld: 39, validDrivingLicense: true, vehilceCategory: ["B", "B1"], expierenceInYear: nil)
]
var sportCarDriverRequirements = DriverRequirements(yearsOld: 18, validDrivingLicense: true, requiredExperienceInYear: 3, requiredCategory: "B")
var trunkCarDriverRequirements = DriverRequirements(yearsOld: 18, validDrivingLicense: true, requiredExperienceInYear: 5, requiredCategory: "C")
var mazda6 = SportCar(brand: "Mazda", model: "6", assemblyDate: Date(), trunkVolume: 440.0, turboBoost: false, limitedEdition: false, carOwners: carOwners, driverRequirements: sportCarDriverRequirements)
var volvo = TrunkCar(brand: "Volvo", model: "XT1500", assemblyDate: Date(), trunkVolume: 1500, allWheelDrive: true, carOwners: carOwners, driverRequirements: trunkCarDriverRequirements)

// ПРОВЕРКА к заданию 1 на примере класса SportCar
//
//if let error = mazda6.operateTrunk(trunkModifier: .loadIn, luggage: 200) {
//    print("Error: \(error)" + error.localizedDescription)
//}
//if let error = mazda6.operateTrunk(trunkModifier: .loadIn, luggage: 241) {
//    print("Error: \(error)")
//}
//if let error = mazda6.operateTrunk(trunkModifier: .loadOut, luggage: 201) {
//    print("Error: \(error)")
//}
//print(mazda6.trunkFilledVolume)
//
//if let error = mazda6.useSpecialAbility() {
//    print("Error: \(error) /" + error.localizedDescription)
//}
//if let error = volvo.useSpecialAbility() {
//    print("Error: \(error) /" + error.localizedDescription)
//}
//
// ПРОВЕРКА к заданию 2 на примере класса TrunkCar
//
//do {
//    try mazda6.turnEngine(engineModifier: .on, carOwner: carOwners["Dad"]!)
//} catch operationError.accessDenied {
//    print("Access denied for this owner!")
//} catch let error {
//    print(error.localizedDescription)
//}
//do {
//    try mazda6.turnEngine(engineModifier: .on, carOwner: carOwners["Son"]!)
//} catch operationError.accessDenied {
//    print("Access denied for this owner!")
//} catch let error {
//    print(error.localizedDescription)
//}
//
//do {
//    try volvo.callRoadHelp(carOwner: carOwners["Mom"]!)
//} catch operationError.accessDenied {
//    print("Driver has no authority!")
//} catch let error {
//    print(error.localizedDescription)
//}
//do {
//    try volvo.callRoadHelp(carOwner: carOwners["Dad"]!)
//} catch operationError.accessDenied {
//    print("Driver has no authority!")
//} catch let error {
//    print(error.localizedDescription)
//}
