import Foundation

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