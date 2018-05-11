//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print(str)

print("--------")

var inteiro = 12
let constante1 = 18
var texto1 = "O valor e: "
print(texto1 + String(inteiro))

print("--------")

let castExplicito: Double = 70
let floatAttr: Float = 10
var stringOpcional1: String? = "Hello"
print(stringOpcional1 == nil)
print(stringOpcional1)

print("--------")

var stringOpcional2: String?
print(stringOpcional2 == nil)
print(stringOpcional2)

print("--------")

var stringOpcional3: String = "Teste"
print(stringOpcional3)
stringOpcional3 = "Felipe"
print(stringOpcional3)

print("--------")

let constante2 = 18
var texto2 = "O valor e: \(10 + constante2)"
print(texto2)

print("--------")

var lista1 = ["leite", "cafe", "pao", "margarina"]
var texto3 = "O valor e: \(lista1[0])"
print(texto3)
print(lista1.sorted(by:<)) // no caso do metodo sorted e obrigatorio nomear o parametro como by, pois na definicao do metodo esta explicita essa exigencia. outros metodos que nao tem essa obrigacao, fica facultativa a nomeacao dos params

print("--------")

var lista2: [Any] = [10, "cafe", "pao", "margarina"]
print(lista2[0])

print("--------")

var lista3 = ["abc", "def"]
lista3.append("ghi") // na verdade temos uma lista, diferentemente do que temos em java, onde arrays nao aceitam acrescimo de novos itens
print(lista3)

print("--------")

var profissoes1 = ["Instrutor": "Telmo",
                    "Aluno": "Felipe"]
profissoes1["Coordenador"] = "Joao"
print(profissoes1["Aluno"])
print(profissoes1["Coordenador"])
print(profissoes1["ValorQualquer"]) // um valor que nao existe retorna nil
print(profissoes1.keys.sorted())

print("--------")

var mapa = ["A":1]
for (key, value) in mapa {
    print("\(key) - \(value)")
}

print("--------")

var profissoes2: [AnyHashable:String] = [10: "agora",
                                            "Teste": "abc"]
print(profissoes2[10])

print("--------")

class Gente {
    var idade = 0
    
    func dizerIdade() -> String {
        return "Eu tenho \(idade) anos"
    }
}

var eu = Gente()
eu.idade = 29
print(eu.dizerIdade())

print("--------")

print("######### aula 17/03/2018")

print("--------")

var n = 2
while n < 100 {
    n *= 2
}
print(n)

print("--------")

var m = 2
repeat {
    m *= 2
} while m < 100
print(m)

print("--------")

let valores = [1, 9, 6, 3, 4]
var maior = 0
for valor in valores {
    if valor > maior { maior = valor }
}
print(maior)

print("--------")

var optionalName: String? = "Joao Silva"
var greeting1 = "Oi!"
if let name = optionalName {
    greeting1 = "Oi, \(name)!"
}
print(greeting1)

print("--------")

var optionalAge: Int? = 18 // se eu remover a atribuicao o if da false
var greeting2 = "Nao sei minha idade"
if let age = optionalAge {
    greeting2 = "Minha idade e: \(age)!"
}
print(greeting2)

print("--------")

let vegetables = "Pimenta malagueta"
switch vegetables {
case "aipo":
    print("Adicione algumas passas.")
case "pepino", "agriao":
    print("Isso daria um bom cha")
case let x where x.hasPrefix("Pimenta"):
    print("A \(x) e ardida?")
default:
    print("Tudo vai bem numa sopa!")
}

print("--------")

let valor = 10
switch valor {
case 1..<10:
    print("entre 1 e 9")
case 10...20:
    print("entre 10 e 20")
default:
    print("nenhum")
}

print("--------")

var total = 0
for i in 0..<4 {
    total += i
}
print(total)

print("--------")

func soma(x: Int, y: Int) -> Int {
    return x + y
}
print(soma(x: 1, y: 2))

print("--------")

func soma2(_ x: Int, _ y: Int) -> Int {
    return x + y
}
print(soma2(1, 2))

print("--------")

func retornaTupla() -> (String, String) {
    return ("ABC", "DEF")
}

print(retornaTupla())

print("--------")

func divisao(a:Int, b:Int) -> (resultado: Int, resto: Int) {
    return (Int(a/b), Int(a%b))
}

print(divisao(a:9, b:8))

print("--------")

// o exemplo abaixo mostra como podemos fazer um retorno composto (tuplas). e como se fosse um json
func somas(x: Int, y: Int, z: Int) -> (s1: Int, s2: Int, s3: Int) {
    return (x + y, x + z, y + z)
}
let result = somas(x: 1, y: 2, z: 3)
print("O valor de s1 e: \(result.s1)")
print("O valor de s2 e: \(result.s2)")
print("O valor de s3 e: \(result.s3)")

print("--------")

func returnFifteen() -> Int {
    var y = 10
    
    func add() {
        y += 5
    }
    
    add()
    
    return y
}
print(returnFifteen())

print("--------")

func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    
    return addOne
}
var increment = makeIncrementer()
print(increment(7))
print(makeIncrementer()(9))

print("--------")

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) { return true }
    }
    
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}
func morethanTen(number: Int) -> Bool {
    return number > 10
}
var numbers = [20, 19, 7, 12]
print(hasAnyMatches(list: numbers, condition: lessThanTen))
print(hasAnyMatches(list: numbers, condition: morethanTen))

print("--------")

var numbers2 = [20, 19, 7, 12]
let others = numbers2.map { (number: Int) -> Int in
    let result = 3 * number
    return result
}

print(others)

print("--------")

let nomes = ["Cris", "Alex", "Eva", "Beto", "Danielle"]
let reverso = nomes.sorted(by: {(s1: String, s2:String) -> Bool in
    return s1 > s2
})
print(nomes)
print(reverso)

let maiusculas = nomes.map {(n: String) -> String in
    return n.uppercased()
}

print(maiusculas)

print("-------- Construtores init() e getters e setters")

class C {
    var a: Int
    var json: String {
        get {
            return "{\"a\": \(a)}"
        }
    }
    
    init() {
        a = 0
    }
}

print(C().json)

print("-------- Enumerations: recursivas")

indirect enum ExpressaoAritmetica {
    case numero(Int)
    case adicao(ExpressaoAritmetica, ExpressaoAritmetica)
    case multiplicacao(ExpressaoAritmetica, ExpressaoAritmetica)
}
let cinco = ExpressaoAritmetica.numero(5)
let quatro = ExpressaoAritmetica.numero(4)
let soma = ExpressaoAritmetica.adicao(cinco, quatro)
let produto = ExpressaoAritmetica.multiplicacao(soma, ExpressaoAritmetica.numero(2))

func avaliar(_ expressao: ExpressaoAritmetica) -> Int {
    switch expressao {
    case let .numero(value):
        return value
    
    // e possivel utilizar apenas o . antes do atributo do enum como no codigo abaixo..
    case let .adicao(esq, dir):
        return avaliar(esq) + avaliar(dir)
        
    // ou de fato fazer a chamada com o nome completo como no codigo abaixo..
    case let ExpressaoAritmetica.multiplicacao(esq, dir):
        return avaliar(esq) * avaliar(dir)
    }
}

print("resultado da expressao: (5 + 4) * 2 = \(avaliar(produto)))")

print("-------- Protocols (interfaces em java)")

class ClasseMae {}
protocol UmProtocolo {
    var propriedadeDeInstancia: Int { get set }
    static var propriedadeEstatica: String { get set }
}
protocol OutroProtocolo {
    func metodoDeInstancia() -> Int
    static func metodoEstatico() -> String
}
// A heranca deve ser o primeiro item a ser declarado, e logo dps devem vir os protocols..
// Neste caso a heranca e ClasseMae e UmProtocolo e o protocol
class MinhaClasse: ClasseMae, UmProtocolo, OutroProtocolo {
    func metodoDeInstancia() -> Int {
        return 0
    }
    
    static func metodoEstatico() -> String {
        return ""
    }
    
    var propriedadeDeInstancia: Int = 0
    
    static var propriedadeEstatica: String = ""

}

print("-------- Extensions")

extension OutroProtocolo {
    func metodoDeInstancia() -> Int { return 0 }
    static func metodoEstatico() -> String { return "Felipao" }
}

class ABC: OutroProtocolo { }

print(ABC.metodoEstatico())

print("-------- Defer: usado em IO para fechar os arquivos abertos close(). e como se fosse um finnaly do try catch")

func F1() {
    defer {
        print("bloco 1")
    }
    defer {
        print("bloco 2")
    }
}

F1()

print("--------")

enum MeusErros: Error {
    case abrir, fechar
}

func negocio() throws {
    throw MeusErros.abrir
}

do {
    try negocio()
} catch {
    print(error)
    print("\(error)")
}

print("--------")
print("--------")
print("--------")
print("--------")
print("--------")
print("--------")
print("--------")
