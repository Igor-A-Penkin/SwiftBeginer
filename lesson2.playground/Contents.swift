import Cocoa

// 1. Написать функцию, которая определяет, четное число или нет.
func evenNumber(_ num: Int) -> Bool {
    return num%2==0
}



//2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func divisionByThree(_ num: Int) -> Bool {
    return num%3==0
}



//3. Создать возрастающий массив из 100 чисел.
func createPlainArray(length: Int) -> [Int] {
    var array = [Int]()
    for i in 1...length {
        array.append(i)
    }
    return array
}



//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
func cleanArray(array: [Int]) -> [Int] {
    return array.filter{ i in (i%2>0 && i%3==0)}
}



//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
func createFibonacciRow() -> [Decimal] {
    // array[91]  =  7 540 113 804 746 346 429
    // array[92]  = 12 200 160 415 121 876 738
    // UInt64.max = 18 446 744 073 709 551 615
    // array[93]  = 19 740 274 219 868 223 167 > UInt64.max
    // Double(array[93]) = 1.974027421986822e+19
    // Для предотвращения потери точности используется Decimal
    var array: [Decimal] = [1.0, 1.0]
    for i in array.count...99 {
        array.append(array[i-2] + array[i-1])
    }
    return array
}



//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
func methodOfEratosphen() -> [Int] {
    var array: [Int] = [0]
    let n: Int = 1000
    for i in 1...n {
        array.append(i)
    }
    
    var p: Int = 2
    var arraySimple: [Int] = [p]
    var startPoint: Int = p
    var breaker: Int = 0
    
    while arraySimple.count < 100 && breaker <= n {
        while startPoint+p <= n {
            array[startPoint+p] = 0
            p = startPoint + p
        }
        p = startPoint
        for i in startPoint...n {
            breaker = i+1
            if array[i] > p {
                p = array[i]
                arraySimple.append(p)
                startPoint = p
                break
            }
        }
    }
    return arraySimple
}
//print(methodOfEratosphen().count)
//print(methodOfEratosphen())
