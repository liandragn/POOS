import Foundation

// Dia 1

class Pessoa {
    let nome: String
    var email: String

    func getDescricao() -> String {
        return "Nome: \(nome), Email: \(email)"
    }  

    init(nome: String, email: String) {
        self.nome = nome
        self.email = email
    } 
}

enum NivelAluno {
    case iniciante
    case intermediario
    case avancado
}

class Aluno: Pessoa {
    let matricula: String 
    var nivel: NivelAluno = .iniciante
    private(set) var plano: Plano

    init(nome: String, email: String, matricula: String, plano: Plano) {
        self.matricula = matricula
        self.plano = plano
        super.init(nome: nome, email: email)
    }

    override func getDescricao() -> String {
        let descricaoPai = super.getDescricao()
        return "\(descricaoPai), Matrícula: \(matricula), Plano: \(plano.nome)"
    }
}

class Instrutor: Pessoa {
    let especialidade: String

    init(nome: String, email: String, especialidade: String) {
        self.especialidade = especialidade
        super.init(nome: nome, email: email)
    }

    override func getDescricao() -> String {
        let descricaoPai = super.getDescricao()
        return "\(descricaoPai), Especialidade: \(especialidade)"
    }
}

class Plano {
    let nome: String

    func calcularMensalidade() -> Double {
        return 0.0
    }

    init(nome: String) {
        self.nome = nome
    }
}

class PlanoMensal: Plano {
    init() {
        super.init(nome: "Plano Mensal")
    }

    override func calcularMensalidade() -> Double {
        return 120.0
    }
}

class PlanoAnual: Plano {
    init() {
        super.init(nome: "Plano Anual (Promocional)")
    }

    override func calcularMensalidade() -> Double {
        let custoTotal = 12.0 * 120.0
        let custoComDesconto = custoTotal * (1.0 - 0.20)
        return custoComDesconto / 12.0
    }
}