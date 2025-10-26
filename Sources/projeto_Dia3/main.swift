import Foundation

// Dia 3

class Academia {
    let nome: String
    private var alunosMatriculados: [String: Aluno]
    private var instrutoresContratados: [String: Instrutor]
    private var aparelhos: [Aparelho]
    private var aulasDisponiveis: [Aula]

    init(nome: String) {
        self.nome = nome
        self.alunosMatriculados = []
        self.instrutoresContratados = []
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