//
//  func.swift
//  Simple calculations
//
//  Created by Павел Ходенков on 06.02.2023.
//

import Foundation

//запрос и проверка номера операции
func chekNumberOperation() -> UInt8 {
    var result = UInt8()
    for _ in 1... {
        print("""
Введите номер операции и нажмите Enter:
1) сложение
2) умножение
3) вычитание
4) деление
5) возведение в степень
""")
        guard let value = UInt8(readLine() ?? ""), (1...5).contains(value) else {
            print("Введено некорректное значение. Попробуйте ещё раз...")
            continue
        }
        result = value
        break
    }
    return result
}

//запрос и проверка количества аргументов
func chekCountArguments(_ numberOperation: UInt8) -> UInt8 {
    var result = UInt8()
    if (1...4).contains(numberOperation) {
        for _ in 1... {
            print("Введите количество аргументов >= 2 и нажмите Enter")
            guard let countArguments = UInt8(readLine() ?? ""), countArguments >= 2 else {
                print("Введено число < 2, либо значение содержащее не цифровой символ. Попробуйте ещё раз...")
                continue
            }
            result = countArguments
            break
        }
    } else {
        result = 2
    }
    return result
}

//запрос и проверка аргументов
func chekArgument(_ numberArgument: UInt8, _ countArguments: UInt8) -> [Double] {
    var result = [Double]()
    var number = numberArgument
    while number <= countArguments {
        for _ in 1... {
            print("Ввведите аргумент № \(number) и нажмите Enter")
            guard let argument = Double(readLine() ?? "") else {
                print("Введено значение содержащее не цифровой символ. Попробуйте ещё раз...")
                continue
            }
            number += 1
            result.append(argument)
            break
        }
    }
    return result
}

//выполнение операции
func doOperation(_ arguments: [Double], _ numberOperation: UInt8) -> Double {
    var result = Double()
    var copyArguments = arguments
    let firstArgument = copyArguments.remove(at: 0)
    switch numberOperation {
    case 1:
        result = arguments.reduce(0, +)
    case 2:
        result = arguments.reduce(1, *)
    case 3:
        result = copyArguments.reduce(firstArgument, -)
    case 4:
        result = copyArguments.reduce(firstArgument, /)
    case 5:
        result = pow(arguments[0], arguments[1])
    default:
        break
    }
    return result
}
