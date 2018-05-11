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
    var indice = 1
    
    //public init?() {
    public init() throws {
        
        router.all(middleware: BodyParser())
        // Run the metrics initializer
        initializeMetrics(router: router)
    }

    func imprimir<T>(_ oQue : T) {
        print("\(oQue)")
    }
    
    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        
        router.post("/compra") { // Create
            request, response, next in
            self.imprimir(request)
            if let data = request.body?.asJSON,
                let compra = Compra(json: data) {
                let chave = self.indice
                self.indice += 1
                compra.id = chave
                self.compras[chave] = compra
                response.send(JSON(compra.asMap()).description)
            }
            next()
        }
        
        router.get("/compra") { // Read all
            request, response, next in
            var result: [Any] = []
            for valor in self.compras.values {
                result.append(valor)
            }
            response.send(JSON(result).description)
            next()
        }
        
        router.get("/compra/:id") { // Read
            request, response, next in
            if let chaveStr = request.parameters["id"],
                let chave = Int(chaveStr),
                let data = self.compras[chave] {
                response.send(JSON(data).description)
            }
            next()
        }
        
        router.put("/compra/:id") { // Update
            request, response, next in
            if let chaveStr = request.parameters["id"],
                let chave = Int(chaveStr),
                let data = request.body?.asJSON,
                let compra = Compra(json: data) {
                self.compras[chave] = compra
                compra.id = chave
                response.send(JSON(compra.asMap()).description)
            }
            next()
        }
        
        router.delete("/compra/:id") { // Delete
            request, response, next in
            if let chaveStr = request.parameters["id"],
                let chave = Int(chaveStr),
                let data = self.compras[chave] {
                self.compras[chave] = nil
                response.send(JSON(data).description)
            }
            next()
        }
        
        router.get("/") {
            request, response, next in
            response.send("Hello, World!")
            next()
        }
    }
    
    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
