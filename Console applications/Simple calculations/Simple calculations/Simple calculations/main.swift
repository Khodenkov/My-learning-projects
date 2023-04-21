//
//  main.swift
//  Simple calculations
//
//  Created by Павел Ходенков on 06.02.2023.
//

import Foundation

//указатель на операцию
var numberOperation = chekNumberOperation()
//количество аргументов
var countArguments = chekCountArguments(numberOperation)
//массив аргументов
var arguments = chekArgument(1, countArguments)
//результат вычисления
var result = doOperation(arguments, numberOperation)
//вывод результата на консоль
print("Результат вычисления операции под номером \(numberOperation): \(result)")












