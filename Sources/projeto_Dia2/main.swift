import Foundation

// Dia 2

protocol Manutencao {
    var nomeItem: String
    var dataUltimaManutencao: String

    func realizarManutencao() -> Bool
}

class Aparelho: Manutencao {
    let nomeItem: String
    private(set) var dataUltimaManutencao: String = "Nenhuma"

    init(nomeItem: String) {
        self.nomeItem = nomeItem
    }

    func realizarManutencao() -> Bool {
        print("Iniciando manutenção para o aparelho: \(nomeItem)...")
        self.dataUltimaManutencao = "30/08/2025"
        print("Manutenção do \(nomeItem) concluída com sucesso. Nova data: \(dataUltimaManutencao).")
        return true
    }
}

class Aula {
    let nome: String
    let instrutor: Instrutor

    init(nome: String, instrutor: Instrutor) {
        self.nome = nome
        self.instrutor = instrutor
    }

    func getDescricao() -> String {
        return "Aula: \(nome), Instrutor: \(instrutor.nome)"
    }
}

class AulaPersonal: Aula {
    let aluno: Aluno

    init(nome: String, instrutor: Instrutor, aluno: Aluno) {
        self.aluno = aluno
        super.init(nome: nome, instrutor: instrutor)
    }

    override func getDescricao() -> String {
        let descricaoBase = super.getDescricao()
        return "\(descricaoBase),  Aluno: \(aluno.nome) (Matrícula: \(aluno.matricula))"
    }
}

class AulaColetiva: Aula {
    private(set) var alunosInscritos: [String: Aluno]
    let capacidadeMaxima: Int = 25

    func inscrever(aluno: Aluno) -> Bool {
        if alunosInscritos.count >= capacidadeMaxima {
            print("Aviso: A aula de \(self.nome) atingiu a capacidade máxima de \(capacidadeMaxima) alunos. Inscrição negada para \(aluno.nome).")
            return false
        }

        if alunosInscritos[aluno.matricula] != nil {
            print("Error: O aluno \(aluno.nome) (Matrícula: \(aluno.matricula)) já está inscrito na aula de \(self.nome).")
            return true
        }

        alunosInscritos[aluno.matricula] = aluno
        print("Sucesso: Aluno \(aluno.nome) inscrito na aula de \(self.nome). Vagas restantes: \(capacidadeMaxima - alunosInscritos.count).")
        return true
    }

    override func getDescricao() -> String {
        let descricaoBase = super.getDescricao()
        let vagasOcupadas = alunosInscritos.count
        return "\(descricaoBase),  Turma: \(vagasOcupadas) / \(capacidadeMaxima) alunos inscritos."
    }
}