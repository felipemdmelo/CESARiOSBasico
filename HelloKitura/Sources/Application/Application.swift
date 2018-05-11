import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import SwiftyJSON

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()
    var compras: [Int:Compra] = [:]
    var vendas: [Int:Venda] = [:]
    var indice = 1
    var indiceVendas = 1

    public init() throws {
        router.all(middleware: BodyParser())
        // Run the metrics initializer
        initializeMetrics(router: router)
    }

    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        
        // Handle HTTP GET requests to /
        router.get("/") {
            request, response, next in
            response.send("Hello, World!")
            next()
        }
        
        func funcaoHandle<Tipo: Vendavel>(_ lista: [Int:Tipo], _ request: RouterRequest, _ response: RouterResponse, _ next: () -> Void) {
            var result: [Any] = []
            for valor in lista.values {
                result.append(valor.asMap())
            }
            response.send(JSON(result).description)
            next()
        }
        
        // Venda...
        router.get("/venda") {
            request, response, next in
            funcaoHandle(self.vendas, request, response, next)
        }
        
        // Compra...
        router.get("/compra") {
            request, response, next in
            funcaoHandle(self.compras, request, response, next)
        }
        
        router.post("/compra") {
            request, response, next in
            do {
                if let data = request.body?.asJSON,
                    let compra = try Compra(json: data) {
                    let chave = self.indice
                    self.indice += 1
                    compra.id = chave
                    self.compras[chave] = compra
                    
                    response.send(JSON(compra.asMap()).description)
                }
            } catch CompraErros.precoInvalido {
                response.send("O preco esta invalido")
            } catch CompraErros.valorAusente {
                response.send("A quantidade esta ausente")
            }
            next()
        }
        
        router.get("/compra/:id") {
            request, response, next in
            if let chaveStr = request.parameters["id"],
                let chave = Int(chaveStr),
                let data = self.compras[chave] {
                    response.send(JSON(data.asMap()).description)
            }
            next()
        }
        
        router.put("/compra/:id") {
            request, response, next in
            do {
                if let chaveStr = request.parameters["id"],
                    let chave = Int(chaveStr),
                    let data = request.body?.asJSON,
                    let compra = try Compra(json: data) {
                    compra.id = chave
                    self.compras[chave] = compra
                    response.send(JSON(compra.asMap()).description)
                }
            } catch CompraErros.precoInvalido {
                response.send("O preco esta invalido")
            } catch CompraErros.valorAusente {
                response.send("A quantidade esta ausente")
            }
            next()
        }
        
        router.delete("/compra/:id") {
            request, response, next in
            if let chaveStr = request.parameters["id"],
                let chave = Int(chaveStr),
                let data = self.compras[chave] {
                self.compras[chave] = nil
                response.send(JSON(data.asMap()).description)
            }
            next()
        }
        
        
        
  
        
        router.post("/venda") {
            request, response, next in
            do {
                if let data = request.body?.asJSON,
                    let venda = try Venda(json: data) {
                    let chave = self.indiceVendas
                    self.indiceVendas += 1
                    venda.id = chave
                    self.vendas[chave] = venda
                    
                    response.send(JSON(venda.asMap()).description)
                }
            } catch CompraErros.precoInvalido {
                response.send("O preco esta invalido")
            } catch CompraErros.valorAusente {
                response.send("A quantidade esta ausente")
            }
            next()
        }
        
        router.get("/venda/:id") {
            request, response, next in
            if let chaveStr = request.parameters["id"],
                let chave = Int(chaveStr),
                let data = self.vendas[chave] {
                response.send(JSON(data.asMap()).description)
            }
            next()
        }
        
        router.put("/venda/:id") {
            request, response, next in
            do {
                if let chaveStr = request.parameters["id"],
                    let chave = Int(chaveStr),
                    let data = request.body?.asJSON,
                    let venda = try Venda(json: data) {
                    venda.id = chave
                    self.vendas[chave] = venda
                    response.send(JSON(venda.asMap()).description)
                }
            } catch CompraErros.precoInvalido {
                response.send("O preco esta invalido")
            } catch CompraErros.valorAusente {
                response.send("A quantidade esta ausente")
            }
            next()
        }
        
        router.delete("/venda/:id") {
            request, response, next in
            if let chaveStr = request.parameters["id"],
                let chave = Int(chaveStr),
                let data = self.vendas[chave] {
                self.vendas[chave] = nil
                response.send(JSON(data.asMap()).description)
            }
            next()
        }
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
