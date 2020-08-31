import Cocoa
import Foundation


// Задание No.1 - Решить квадратное уравнение.

class QuadraticEquation {
    private var coefficientOne: Double
    private var coefficientTwo: Double
    private var freeMember: Double

    init(coefficientOne: Double, coefficientTwo: Double, freeMember: Double) {
        self.coefficientOne = coefficientOne
        self.coefficientTwo = coefficientTwo
        self.freeMember = freeMember
    }

    public func changeProperties(coefficientOne: Double, coefficientTwo: Double, freeMember: Double) {
        self.coefficientOne = coefficientOne
        self.coefficientTwo = coefficientTwo
        self.freeMember = freeMember
    }

    private func findDiscriminans() -> Double {
        let discriminans: Double
        discriminans = pow(coefficientTwo, 2) - 4*coefficientOne*freeMember
        return discriminans
    }

    public func showSolution() {
        let discriminans: Double = findDiscriminans()
        print("Equation \(coefficientOne)*x^2 + \(coefficientTwo)*x + \(freeMember) = 0 has")
        if discriminans > 0 {
            var root: Double = (-1*coefficientTwo + discriminans.squareRoot())/(2*coefficientOne)
            print("X1 = \(root)")
            root = (-1*coefficientTwo - sqrt(discriminans))/(2*coefficientOne)
            print("X2 = \(root)")
        } else if discriminans == 0 {
            let root: Double = -coefficientTwo/(2*coefficientOne)
            print("X = \(root)")
        } else {
            print("no roots!")
        }
    }
}

// Проверка к Заданию 1
//var equation = QuadraticEquation(coefficientOne: 1, coefficientTwo: 0, freeMember: -4)
//equation.showSolution()
//equation.changeProperties(coefficientOne: 4, coefficientTwo: -12, freeMember: 9)
//equation.showSolution()
//equation.changeProperties(coefficientOne: 1, coefficientTwo: -5, freeMember: 10)
//equation.showSolution()


// Задание No.2 - Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

class RightTriangle {
    private var legOne: Double
    private var legTwo: Double

    init(legOne: Double, legTwo: Double) {
        self.legOne = legOne
        self.legTwo = legTwo
    }

    public func changeProperties(legOne: Double, legTwo: Double) {
        self.legOne = legOne
        self.legTwo = legTwo
    }

    public func getSquare() -> Double{
        return 0.5*legOne*legTwo
    }

    public func getPerimeter() -> Double {
        return 2*(legOne+legTwo)
    }

    public func getHypotenuse() -> Double {
        return (pow(legOne, 2) + pow(legTwo, 2)).squareRoot()
    }
}

// Проверка к Заданию 2
//var triangle = RightTriangle(legOne: 6, legTwo: 8)
//print(triangle.getSquare())
//print(triangle.getPerimeter())
//print(triangle.getHypotenuse())


// Задание No.3 - Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

class Deposit {
    private var amount: Decimal
    private let periodInYear: Int = 5
    private var percentage: Decimal
    
    init(amount: Decimal, percentage: Decimal) {
        self.amount = amount
        self.percentage = percentage
    }
    
    public func getTotalAmountWithPercentageCapitalization() -> Decimal {
        var totalAmount: Decimal = amount
        totalAmount = amount
        for _: Int in 1...(periodInYear*12) {
            totalAmount = totalAmount + totalAmount*(percentage/12) // так как капитализация по вкладу предполагает ежемесячное зачисление процентов на счет
        }
        var result: Decimal = Decimal()
        NSDecimalRound(&result, &totalAmount, 2, .plain)
        return result
    }
    
    public func getTotalAmountWithOutPercentageCapitalization() -> Decimal {
        var totalAmount: Decimal = amount
        for _: Int in 1...(periodInYear) {
            totalAmount = totalAmount + totalAmount*(percentage) // если процент зачисляется раз в год
        }
        var result: Decimal = Decimal()
        NSDecimalRound(&result, &totalAmount, 2, .plain)
        return result
    }
}
// Проверка к Заданию 3
//var newDeposit = Deposit(amount: 10000.00, percentage: 0.1)
//print(newDeposit.getTotalAmountWithOutPercentageCapitalization())
//print(newDeposit.getTotalAmountWithPercentageCapitalization())
