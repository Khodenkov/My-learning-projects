import UIKit

//Сущность "Шахматная фигура"
class Chessman {
    
    //Сущность "Тип шахматной фигуры"
    enum ChessmanType {
        case king, castle, bishop, pawn, knight, queen
    }
    //Сущность "Цвет шахматной фигуры"
    enum ChessmanColor {
        case black, white
    }
    //Тип шахматной фигуры
    let type: ChessmanType
    //Цвет шахматной фигуры
    let color: ChessmanColor
    //Координаты шахматной фигуры
    var coordinates: (String, Int)? = nil
    //Графическое изображение шахматной фигуры
    let figureSymbol: String
    
    init(type: ChessmanType, color: ChessmanColor, figure:
         String) {
        self.type = type
        self.color = color
        figureSymbol = figure
    }
    init(type: ChessmanType, color: ChessmanColor, figure:
         String, coordinates: (String, Int)) {
        self.type = type
        self.color = color
        figureSymbol = figure
        setCoordinates(char: coordinates.0, num:coordinates.1)
    }
    
    //Установка координат шахматной фигуре
    func setCoordinates(char c:String, num n: Int) {
        coordinates = (c, n)
    }
    //Удаление координат у шахматной фигуры
    func kill() {
        coordinates = nil
        
    }
}

//Сущность "Шахматная доска"
class GameDesk {
    
    //Игровое поле
    var desk: [Int:[String:Chessman]] = [:]
    //Зона убитых черных фигур
    var areaKillBlackSymols = ""
    //Зона убитых белых фигур
    var areaKillWhiteSymols = ""
    
    init(){
        for i in 1...8 {
            desk[i] = [:]
        }
        
    }
    
    //Получение доступа к ячейке, возврат её значения и установка нового значения
    subscript(number: Int, alpha: String) -> Chessman? {
        get {
            return self.desk[number]?[alpha]
        }
        set {
            if let chessman = newValue {
                self.setChessman(chess: chessman, coordinates: (alpha, number))
            } else {
                self.killChessman(coordinates: (alpha, number))
            }
        }
    }
    //Получение доступа к шахматной фигуре и возврат её графического изображения
    private subscript(alpha: String, number: Int) -> String {
        return self.desk[number]?[alpha]?.figureSymbol ?? "_"
    }
    //Получение доступа к ячейкам и передвижение фигуры с одной ячейки на другую
    subscript(oldCoordinates: (String, Int), newCoordinates: (String, Int)) -> String {
        return self.gameRules(from: oldCoordinates, to: newCoordinates)
    }
    //Установка шахматной фигуры на игровом поле
    private func setChessman(chess: Chessman , coordinates: (String, Int)) {
        let rowRange = 1...8
        let colRange = "A"..."H"
        if( rowRange.contains( coordinates.1 ) && colRange.contains(
            coordinates.0 ) ) {
            self.desk[coordinates.1]![coordinates.0] = chess
            chess.setCoordinates(char: coordinates.0, num: coordinates.1)
        } else {
            print("Coordinates out of range")
        }
    }
    //Удаление убитой шахматной фигуры с игрового поля и добавление её графического изображения за его пределы
    private func killChessman(coordinates: (String, Int)) {
        let rowRange = 1...8
        let colRange = "A"..."H"
        if( rowRange.contains( coordinates.1 ) && colRange.contains(
            coordinates.0 ) ) {
            switch self.desk[coordinates.1]![coordinates.0]?.color {
            case .black:
                self.areaKillBlackSymols += self.desk[coordinates.1]![coordinates.0]!.figureSymbol
            case .white:
                self.areaKillWhiteSymols += self.desk[coordinates.1]![coordinates.0]!.figureSymbol
            default:
                break
            }
            self.desk[coordinates.1]![coordinates.0]?.kill()
            self.desk[coordinates.1]![coordinates.0] = nil
        } else {
            print("Coordinates out of range")
        }
    }
    //Передвижение фигуры с одной клетки на другую
    private func move(chessman: Chessman, to: (String, Int)){
        self.killChessman(coordinates: chessman.coordinates!)
        switch chessman.color {
        case .black:
            self.areaKillBlackSymols.removeLast()
        case .white:
            self.areaKillWhiteSymols.removeLast()
        }
        self.setChessman(chess: chessman, coordinates: to)
    }
    //Правила перемещения шахматных фигур (реализовано только для пешки)
    private func gameRules(from: (String, Int), to: (String, Int)) -> String {
        var result = String()
        //проверка наличия шаматной фигуры относительно старых координат, откуда производится попытка перемещения
        if let chessman = self.desk[from.1]?[from.0] {
            //коллекция буквенных координат
            let letterCoord = " ABCDEFGH "
            //индекс старой буквенной координаты в коллекции letterCoord
            var oldLetterIndex = (letterCoord.firstIndex(of: Character(from.0)))!
            //буквенная координата, расположенная до старой буквенной координаты, в коллекции letterCoord
            var bLtr = String(letterCoord[letterCoord.index(before: oldLetterIndex)])
            //буквенная координата, расположенная после старой буквенной координаты, в коллекции letterCoord
            var aLtr = String(letterCoord[letterCoord.index(after: oldLetterIndex)])
            //цвет шахматной фигуры
            let colorChessman = chessman.color
            //поиск соответсвующей шахматной фигуры
            switch chessman.type {
            case .pawn:
                //проверка условий при попытке убийства шахматной фигуры противника
                if (to == (bLtr,(from.1) + 1) || to == (aLtr,(from.1) + 1) || to == (bLtr,(from.1) - 1) || to == (aLtr,(from.1) - 1)),
                   let valueTo = self.desk[to.1]?[to.0],
                   valueTo.color != colorChessman {
                    self.killChessman(coordinates: from)
                    switch colorChessman {
                    case .black:
                        self.areaKillBlackSymols.removeLast()
                    case .white:
                        self.areaKillWhiteSymols.removeLast()
                    }
                    self.killChessman(coordinates: to)
                    self.setChessman(chess: chessman, coordinates: to)
                    result = "Фигура противника убита"
                    //проверка условий при попытке первого хода на 1 или 2 клетки вперёд
                } else if ((from.1) == 2 && (to == (from.0,(from.1) + 1) || to == (from.0,(from.1) + 2))) ||
                          ((from.1) == 7 && (to == (from.0,(from.1) - 1) || to == (from.0,(from.1) - 2))),
                          (self.desk[to.1]?[to.0]) == nil {
                    self.move(chessman: chessman, to: to)
                    result = "Фигура перемещена"
                    //проверка условий при попытке второго и более ходов на 1 клетку вперед
                } else if (to == (from.0,(from.1) + 1) || to == (from.0,(from.1) - 1)), (self.desk[to.1]?[to.0]) == nil {
                    self.move(chessman: chessman, to: to)
                    result = "Фигура перемещена"
                }
            default:
                break
            }
            return result
            //отсутсвие шахматной фигуры в ячейке, откуда производится попытка перемещения
        } else {
            result = "Фигура отсутствует"
            return result
        }
    }
    //Вывод изображения шахматной доски на консоль
    func printDeck() {
        print("""
              \(self.areaKillBlackSymols)
              1 \(game["A",1]) \(game["B",1]) \(game["C",1]) \(game["D",1]) \(game["E",1]) \(game["F",1]) \(game["G",1]) \(game["H",1])
              2 \(game["A",2]) \(game["B",2]) \(game["C",2]) \(game["D",2]) \(game["E",2]) \(game["F",2]) \(game["G",2]) \(game["H",2])
              3 \(game["A",3]) \(game["B",3]) \(game["C",3]) \(game["D",3]) \(game["E",3]) \(game["F",3]) \(game["G",3]) \(game["H",3])
              4 \(game["A",4]) \(game["B",4]) \(game["C",4]) \(game["D",4]) \(game["E",4]) \(game["F",4]) \(game["G",4]) \(game["H",4])
              5 \(game["A",5]) \(game["B",5]) \(game["C",5]) \(game["D",5]) \(game["E",5]) \(game["F",5]) \(game["G",5]) \(game["H",5])
              6 \(game["A",6]) \(game["B",6]) \(game["C",6]) \(game["D",6]) \(game["E",6]) \(game["F",6]) \(game["G",6]) \(game["H",6])
              7 \(game["A",7]) \(game["B",7]) \(game["C",7]) \(game["D",7]) \(game["E",7]) \(game["F",7]) \(game["G",7]) \(game["H",7])
              8 \(game["A",8]) \(game["B",8]) \(game["C",8]) \(game["D",8]) \(game["E",8]) \(game["F",8]) \(game["G",8]) \(game["H",8])
                A B C D E F G H
              \(self.areaKillWhiteSymols)
              """)
    }
}
var game = GameDesk()
var queenBlack = Chessman(type: .queen, color: .black, figure: "\u{265B}")
var bishopBlack = Chessman(type: .bishop, color: .black, figure: "\u{265D}")
var pawnWhite = Chessman(type: .pawn, color: .white, figure: "\u{2659}")
var knightWhite = Chessman(type: .knight, color: .white, figure: "\u{2658}", coordinates: ("E", 7))
game[7,"E"] = knightWhite
game[5,"C"] = queenBlack
game[3,"G"] = bishopBlack
game[2,"H"] = pawnWhite
game[2,"G"] = pawnWhite
game.printDeck()
game[("H",2),("G",3)]
game.printDeck()
game[("G",3),("F",4)]
game.printDeck()
game[("G",3),("G",4)]
game.printDeck()

