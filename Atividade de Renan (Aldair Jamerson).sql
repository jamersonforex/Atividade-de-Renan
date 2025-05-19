-- Criação do banco de dados
DROP DATABASE IF EXISTS BibliotecaDB;
CREATE DATABASE BibliotecaDB;
USE BibliotecaDB;

-- Tabela: Autores
CREATE TABLE Autores (
    AutorID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Nacionalidade VARCHAR(50)
);

-- Tabela: Livros
CREATE TABLE Livros (
    LivroID INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(200),
    Genero VARCHAR(50),
    AnoPublicacao INT,
    AutorID INT,
    FOREIGN KEY (AutorID) REFERENCES Autores(AutorID)
);

-- Tabela: Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Email VARCHAR(100),
    Cidade VARCHAR(50)
);

-- Tabela: Emprestimos
CREATE TABLE Emprestimos (
    EmprestimoID INT PRIMARY KEY AUTO_INCREMENT,
    LivroID INT,
    UsuarioID INT,
    DataEmprestimo DATE,
    DataDevolucao DATE,
    FOREIGN KEY (LivroID) REFERENCES Livros(LivroID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Inserção: Autores
INSERT INTO Autores (Nome, Nacionalidade) VALUES
('Machado de Assis', 'Brasileira'),
('Clarice Lispector', 'Brasileira'),
('George Orwell', 'Britânica'),
('J.K. Rowling', 'Britânica'),
('Gabriel García Márquez', 'Colombiana'),
('Ernest Hemingway', 'Americana'),
('Jane Austen', 'Britânica'),
('Paulo Coelho', 'Brasileira'),
('Stephen King', 'Americana'),
('Franz Kafka', 'Alemã');

-- Inserção: Livros
INSERT INTO Livros (Titulo, Genero, AnoPublicacao, AutorID) VALUES
('Dom Casmurro', 'Romance', 1899, 1),
('A Hora da Estrela', 'Romance', 1977, 2),
('1984', 'Distopia', 1949, 3),
('Harry Potter e a Pedra Filosofal', 'Fantasia', 1997, 4),
('Cem Anos de Solidão', 'Realismo Mágico', 1967, 5),
('O Velho e o Mar', 'Aventura', 1952, 6),
('Orgulho e Preconceito', 'Romance', 1813, 7),
('O Alquimista', 'Ficção', 1988, 8),
('It - A Coisa', 'Terror', 1986, 9),
('A Metamorfose', 'Ficção', 1915, 10);

-- Inserção: Usuarios
INSERT INTO Usuarios (Nome, Email, Cidade) VALUES
('Ana Silva', 'ana@gmail.com', 'São Paulo'),
('Carlos Souza', 'carlos@yahoo.com', 'Rio de Janeiro'),
('Mariana Lima', 'mariana@hotmail.com', 'Belo Horizonte'),
('João Pedro', 'joao@gmail.com', 'Brasília'),
('Beatriz Costa', 'bia@gmail.com', 'Curitiba'),
('Ricardo Alves', 'ricardo@outlook.com', 'Salvador'),
('Fernanda Rocha', 'fer@gmail.com', 'Fortaleza'),
('Lucas Pereira', 'lucas@gmail.com', 'Recife'),
('Paula Mendes', 'paula@hotmail.com', 'Manaus'),
('Diego Oliveira', 'diego@live.com', 'Porto Alegre');

-- Inserção: Emprestimos
INSERT INTO Emprestimos (LivroID, UsuarioID, DataEmprestimo, DataDevolucao) VALUES
(1, 1, '2025-05-01', '2025-05-10'),
(2, 2, '2025-05-03', '2025-05-12'),
(3, 3, '2025-05-05', '2025-05-15'),
(4, 4, '2025-05-06', NULL),
(5, 5, '2025-05-07', '2025-05-16'),
(6, 6, '2025-05-08', NULL),
(7, 7, '2025-05-09', '2025-05-18'),
(8, 8, '2025-05-10', NULL),
(9, 9, '2025-05-11', NULL),
(10, 10, '2025-05-12', '2025-05-21');

-- Consultas INNER JOIN + LIKE

-- 1. Livros emprestados com nome do usuário
SELECT L.Titulo, U.Nome AS Usuario, E.DataEmprestimo, E.DataDevolucao
FROM Emprestimos E
INNER JOIN Livros L ON E.LivroID = L.LivroID
INNER JOIN Usuarios U ON E.UsuarioID = U.UsuarioID;

-- 2. Livros com o título contendo a letra 'A'
SELECT * FROM Livros
WHERE Titulo LIKE '%A%';

-- 3. Usuários que pegaram livros de autores brasileiros
SELECT DISTINCT U.Nome, A.Nome AS Autor
FROM Emprestimos E
INNER JOIN Livros L ON E.LivroID = L.LivroID
INNER JOIN Autores A ON L.AutorID = A.AutorID
INNER JOIN Usuarios U ON E.UsuarioID = U.UsuarioID
WHERE A.Nacionalidade LIKE '%Brasileira%';

-- 4. Livros de Terror ou Ficção com seus autores
SELECT L.Titulo, L.Genero, A.Nome AS Autor
FROM Livros L
INNER JOIN Autores A ON L.AutorID = A.AutorID
WHERE L.Genero LIKE '%Terror%' OR L.Genero LIKE '%Ficção%';

-- 5. Empréstimos em que o nome do usuário começa com "A"
SELECT E.EmprestimoID, U.Nome, L.Titulo
FROM Emprestimos E
INNER JOIN Usuarios U ON E.UsuarioID = U.UsuarioID
INNER JOIN Livros L ON E.LivroID = L.LivroID
WHERE U.Nome LIKE 'A%';
