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

// Dia 2

protocol Manutencao {
    var nomeItem: String {get}
    var dataUltimaManutencao: String {get}

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

// Dia 3

class Academia {
    let nome: String
    private var alunosMatriculados: [String: Aluno]
    private var instrutoresContratados: [String: Instrutor]
    private var aparelhos: [Aparelho]
    private var aulasDisponiveis: [Aula]

    init(nome: String) {
        self.nome = nome
        self.alunosMatriculados = [:]
        self.instrutoresContratados = [:]
        self.aparelhos = []
        self.aulasDisponiveis = []
    }

    func adicionarAparelho(_ aparelho: Aparelho) {
        aparelhos.append(aparelho)
    }

    func adicionarAula(_ aula: Aula) {
        aulasDisponiveis.append(aula)
    }

    func contratarInstrutor(_ instrutor: Instrutor) {
        instrutoresContratados[instrutor.email] = instrutor
    }

    func matricularAluno(_ aluno: Aluno) {
        if alunosMatriculados[aluno.matricula] != nil {
            print("Erro: Aluno com matrícula \(aluno.matricula) já existe.")
        } else {
            alunosMatriculados[aluno.matricula] = aluno
            print("Aluno \(aluno.nome) matriculado com sucesso!")
        }
    }

    func matricularAluno(nome: String, email: String, matricula: String, plano: Plano) -> Aluno {
        let novoAluno = Aluno(nome: nome, email: email, matricula: matricula, plano: plano)
        matricularAluno(novoAluno)
        return novoAluno
    }

    func buscarAluno(porMatricula matricula: String) -> Aluno? {
        return alunosMatriculados[matricula]
    }

    func listarAlunos() {
        print("--- Lista de Alunos Matriculados ---")
        if alunosMatriculados.isEmpty {
            print("Nenhum aluno matriculado.")
        } else {
            for aluno in alunosMatriculados {
                print(aluno.getDescricao())
            }
        }
        print("------------------------------------")
    }

    func listarAulas() {
        print("--- Lista de Aulas Disponíveis ---")
        if aulasDisponiveis.isEmpty {
            print("Nenhuma aula disponível.")
        } else {
            for aula in aulasDisponiveis {
                print(aula.getDescricao())
            }
        }
        print("----------------------------------")
    }
}

// Dia 4

class Academia {
    let nome: String
    let nome: String
    private var alunosMatriculados: [String: Aluno]
    private var instrutoresContratados: [String: Instrutor]
    private var aparelhos: [Aparelho]
    private var aulasDisponiveis: [Aula]

    init(nome: String) {
        self.nome = nome
        self.alunosMatriculados = [:]
        self.instrutoresContratados = [:]
        self.aparelhos = []
        self.aulasDisponiveis = []
        print("Sistema da Academia \(nome) inicializado.")
    }

    func adicionarAparelho(_ aparelho: Aparelho) {
        self.aparelhos.append(aparelho)
        print("Aparelho \(aparelho.nomeItem) adicionado com sucesso.")
    }

    func adicionarAula(_ aula: Aula) {
        self.aulasDisponiveis.append(aula)
        print("Aula de \(aula.nome) adicionada ao calendário.")
    }

    func contratarInstrutor(_ instrutor: Instrutor) {
        let emailChave = instrutor.email
        if instrutoresContratados[emailChave] == nil {
            instrutoresContratados[emailChave] = instrutor
            print("Instrutor \(instrutor.nome) contratado.")
        } else {
            print("Aviso: Instrutor com email \(emailChave) já está contratado.")
        }
    }

    func matricularAluno(_ aluno: Aluno) {
        let matriculaChave = aluno.matricula
        if alunosMatriculados[matriculaChave] != nil {
            print("Erro: Aluno com matrícula \(matriculaChave) já existe.")
        } else {
            alunosMatriculados[matriculaChave] = aluno
            print("Matrícula bem-sucedida! Aluno \(aluno.nome) registrado na academia \(self.nome).")
        }
    }

    func matricularAluno(nome: String, email: String, matricula: String, plano: Plano) -> Aluno {
        let novoAluno = Aluno(nome: nome, email: email, matricula: matricula, plano: plano)
        self.matricularAluno(novoAluno)
        return novoAluno
    }

    func buscarAluno(porMatricula matricula: String) -> Aluno? {
        return alunosMatriculados[matricula]
    }

        //listar alunos?? - não sei consegui formular
}