//
//  StartViewController.swift
//  Right on target
//
//  Created by Павел Ходенков on 05.04.2023.
//

import UIKit

class StartViewController: UIViewController {
    
    //Загрузка графических элементов в память устройства
    override func loadView() {
        super.loadView()
        print("loadView StartViewController")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad StartViewController")
    }
    //Вызов данного метода происходит перед добавлением графических элементов в иерархию View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear StartViewController")
    }
    //Вызов данного метода происходит после добавления графических элементов в иерархию View
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear StartViewController")
    }
    //Вызов данного метода происходит перед удалением графических элементов из иерархии View
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear StartViewController")
    }
    //Вызов данного метода происходит после удаления графических элементов из иерархии View
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear StartViewController")
    }
    //Удаление экземпляра SecondViewController
    deinit {
        print("экземпляр StartViewController удален")
    }
}
