import UIKit

//Замена числа в строке на его текстовый аналог
func newFunc(_ str: String) -> String {
    //шаблоны текстовых аналогов для:
    //единиц
    let dict1 = [0: "", 1: " один", 2: " два", 3: " три", 4: " четыре", 5: " пять", 6: " шесть", 7: " семь", 8: " восемь", 9: " девять"]
    //чисел с 10 до 19
    let dict10 = [0: " десять", 1: " одиннадцать", 2: " двенадцать", 3: " тринадцать", 4: " четырнадцать", 5: " пятнадцать", 6: " шестнадцать", 7: " семнадцать", 8: " восемнадцать", 9: " девятнадцать"]
    //десятков
    let dict10Plus = [2: " двадцать", 3: " тридцать", 4: " сорок", 5: " пятьдесят", 6: " шестьдесят", 7: " семьдесят", 8: " восемьдесят", 9: " девяносто"]
    //сотен
    let dict100 = [1: " сто", 2: " двести", 3: " триста", 4: " четыреста", 5: " пятьсот", 6: " шестьсот", 7: " семьсот", 8: " восемьсот", 9: " девятьсот"]
    //тысяч
    let dict1000 = [0: " тысяч", 1: " одна тысяча", 2: " две тысячи", 3: " три тысячи", 4: " четыре тысячи", 5: " пять тысяч", 6: " шесть тысяч", 7: " семь тысяч", 8: " восемь тысяч", 9: " девять тысяч"]
    //миллионов
    let dict1000000 = [0: " миллионов", 1: " один миллион", 2: " два миллиона", 3: " три миллиона", 4: " четыре миллиона", 5: " пять миллионов", 6: " шесть миллионов", 7: " семь миллионов", 8: " восемь миллионов", 9: " девять миллионов"]
    //миллиардов
    let dict1000000000 = [0: " миллиардов", 1: " один миллиард", 2: " два миллиарда", 3: " три миллиарда", 4: " четыре миллиарда", 5: " пять миллиардов", 6: " шесть миллиардов", 7: " семь миллиардов", 8: " восемь миллиардов", 9: " девять миллиардов"]
    //перевёрнутый задом наперёд массив цифр, содержащихся во входной строке
    var numbers = str.compactMap({Int(String($0))}).reversed()
    //пока пустой массив, предназначенный для слов имён соответствующих цифрам из массива numbers
    var wordNameNumbers = [String]()
    //порядковый номер элемента в массиве numbers
    var count = 1
    //перебор массива numbers и поиск соответствия на основании того, под каким порядковым номером находится элемент в данном массиве
    for i in numbers {
        //при нахождении соответствия, происходит обращение к нужному шаблону имён и добавление в массив wordNameNumbers имя соответсвующей цифры (в последущих итерациях, при необходимости происходит удаление ненужных имён), а также увеличение порядкового номера
        switch i {
        case i where count == 1 || count == 4 || count == 7 || count == 10:
            if count == 1 {
                wordNameNumbers.append(dict1[i]!)
                wordNameNumbers.append(dict10[i]!)
            } else if count == 4 {
                wordNameNumbers.append(dict1000[0]!)
                wordNameNumbers.append(dict1000[i]!)
                wordNameNumbers.append(dict10[i]!)
            } else if count == 7 {
                wordNameNumbers.append(dict1000000[0]!)
                wordNameNumbers.append(dict1000000[i]!)
                wordNameNumbers.append(dict10[i]!)
            } else if count == 10 {
                wordNameNumbers.append(dict1000000000[0]!)
                wordNameNumbers.append(dict1000000000[i]!)
                wordNameNumbers.append(dict10[i]!)
            }
            count += 1
        case i where count == 2 || count == 5 || count == 8 || count == 11:
            if count == 2 {
                if i == 0 {
                    wordNameNumbers.removeLast()
                } else if i == 1 {
                    wordNameNumbers.removeFirst()
                } else {
                    wordNameNumbers.removeLast()
                    wordNameNumbers.append(dict10Plus[i]!)
                }
            } else {
                if i == 0 {
                    wordNameNumbers.removeLast()
                    wordNameNumbers.remove(at: wordNameNumbers.count-2)
                } else if i == 1 {
                    wordNameNumbers.remove(at: wordNameNumbers.count-2)
                } else {
                    wordNameNumbers.removeLast()
                    wordNameNumbers.remove(at: wordNameNumbers.count-2)
                    wordNameNumbers.append(dict10Plus[i]!)
                }
            }
            count += 1
        case i where count == 3 || count == 6 || count == 9 || count == 12:
            count += 1
            if i == 0 {
                continue
            } else {
                wordNameNumbers.append(dict100[i]!)
            }
        default:
            break
        }
    }
    //перевёрнутый задом наперёд массив слов имён цифр преобразованный в единую строку
    var stringNameNumbers = wordNameNumbers.reversed().reduce("", +)
    //удаление лишнего пробела вначале строки stringNameNumbers
    stringNameNumbers.removeFirst()
    //результирующая строка
    var result = str
    //перебор символов входной строки
    str.map{
        //поиск первого символа представленного в виде цифры
        switch $0 {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            //индекс найденного символа (первого символа числа в строке)
            if let indexFirst = result.firstIndex(of: $0) {
                //индекс последнего символа представленного в виде цифры (последнего символа числа в строке)
                let indexLast = result.index(indexFirst, offsetBy: numbers.count-1)
                //удаление из результирующей строки диапазона символов (удаление числа из строки)
                result.removeSubrange(indexFirst...indexLast)
                //добавление в результирующую строку на место числа строку с именем этого числа
                result.insert(contentsOf: stringNameNumbers, at: indexFirst)
            } else {
                break
            }
        default:
            break
        }
    }
    return result
}
print(newFunc("я заработал 900560315710 рублей"))
