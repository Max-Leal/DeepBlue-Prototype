# Protótipo DeepBlue

Este repositório contém o projeto DeepBlue. Siga as instruções abaixo para clonar o repositório e acessar sua própria branch de desenvolvimento.

## 📥 Como clonar o repositório

Acesse o terminal bash no local da pasta do workspace:

![image](https://github.com/user-attachments/assets/ce72545a-5b2d-43a6-9e2a-e1d85036c4c0)


Para obter uma cópia local deste projeto, execute o seguinte comando no terminal:

```bash
git clone https://github.com/Max-Leal/DeepBlue-Prototype.git
```
## 🌿 Como criar e acessar sua própria branch

Para entrar na sua branch para fazer as tarefas use no terminal onde está aberto o projeto:

```bash
git checkout -b (seu nome)-feature
```


Exemplo: git checkout -b max-feature

## Para mandar arquivos para o github

Acesse o terminal bash do projeto:

![image](https://github.com/user-attachments/assets/c0548fa4-a92c-4460-9b92-542627f24aee)


```bash
git add .
git commit -m "Mensagem descritiva do que foi feito"
git push origin(ou url do repositorio) nome-da-sua-branch
```

## Definir o origin (para ficar mais facil de mandar para o github)

```bash
git remote add origin https://github.com/Max-Leal/DeepBlue-Prototype.git
```

# BANCO DE DADOS DO PROJETO

```sql
CREATE SCHEMA IF NOT EXISTS `deepblue` DEFAULT CHARACTER SET utf8;
USE `deepblue`;

CREATE TABLE IF NOT EXISTS `tb_usuario` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `tipo` ENUM('adm', 'cliente') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`cpf`),
  UNIQUE (`email`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=armscii8;

CREATE TABLE IF NOT EXISTS `tb_agencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_empresarial` VARCHAR(45) NOT NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `situacao` ENUM('disponível', 'indiponível') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`cnpj`),
  UNIQUE (`email`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `tb_passeio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `local` VARCHAR(45) NOT NULL,
  `data` DATE NOT NULL,
  `duracao` TIME NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `tb_agencia_id` INT NOT NULL,
  `tipo` ENUM('normal', 'especial') NOT NULL,
  `situacao` ENUM('disponível', 'indiponível') NOT NULL,
  PRIMARY KEY (`id`, `tb_agencia_id`),
  FOREIGN KEY (`tb_agencia_id`) REFERENCES `tb_agencia` (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `tb_atividade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `localidade` VARCHAR(45) NOT NULL,
  `situacao` ENUM('disponível', 'indiponível') NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `tb_reserva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `tb_usuario_id` INT NOT NULL,
  `tb_passeio_id` INT NOT NULL,
  PRIMARY KEY (`id`, `tb_usuario_id`, `tb_passeio_id`),
  FOREIGN KEY (`tb_usuario_id`) REFERENCES `tb_usuario` (`id`),
  FOREIGN KEY (`tb_passeio_id`) REFERENCES `tb_passeio` (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `tb_avaliacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `escala` ENUM('1', '2', '3', '4', '5') NOT NULL,
  `sugestao` VARCHAR(200) NOT NULL,
  `tb_usuario_id` INT NOT NULL,
  `tb_agencia_id` INT NOT NULL,
  `tb_passeio_id` INT NOT NULL,
  PRIMARY KEY (`id`, `tb_usuario_id`, `tb_agencia_id`, `tb_passeio_id`),
  FOREIGN KEY (`tb_usuario_id`) REFERENCES `tb_usuario` (`id`),
  FOREIGN KEY (`tb_agencia_id`) REFERENCES `tb_agencia` (`id`),
  FOREIGN KEY (`tb_passeio_id`) REFERENCES `tb_passeio` (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `tb_passeio_atividade` (
  `tb_passeio_id` INT NOT NULL,
  `tb_passeio_tb_agencia_id` INT NOT NULL,
  `tb_atividade_id` INT NOT NULL,
  PRIMARY KEY (`tb_passeio_id`, `tb_passeio_tb_agencia_id`, `tb_atividade_id`),
  FOREIGN KEY (`tb_passeio_id`, `tb_passeio_tb_agencia_id`) REFERENCES `tb_passeio` (`id`, `tb_agencia_id`),
  FOREIGN KEY (`tb_atividade_id`) REFERENCES `tb_atividade` (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `tb_usuario_passeio` (
  `tb_usuario_id` INT NOT NULL,
  `tb_passeio_id` INT NOT NULL,
  `tb_passeio_tb_agencia_id` INT NOT NULL,
  PRIMARY KEY (`tb_usuario_id`, `tb_passeio_id`, `tb_passeio_tb_agencia_id`),
  FOREIGN KEY (`tb_usuario_id`) REFERENCES `tb_usuario` (`id`),
  FOREIGN KEY (`tb_passeio_id`, `tb_passeio_tb_agencia_id`) REFERENCES `tb_passeio` (`id`, `tb_agencia_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=armscii8;
```
## Inserts para o banco

### tb_usuario

```sql
INSERT INTO tb_usuario (id, nome, data_nascimento, cpf, email, senha, tipo) VALUES
(1, 'Ana Souza', '1990-05-12', '123.456.789-00', 'ana@email.com', 'senha123', 'cliente'),
(2, 'Carlos Lima', '1985-08-22', '987.654.321-00', 'carlos@email.com', 'abc12345', 'adm');
```

### tb_agencia

```sql
INSERT INTO tb_agencia (nome_empresarial, cnpj, email, senha, situacao) VALUES
('Agência ViagensSol', '12.345.678/0001-99', 'contato@viagenssol.com', 'sol123', 'disponível'),
('Mundo Aventuras', '98.765.432/0001-11', 'aventura@mundo.com', 'aventura@2024', 'disponível');
```

### tb_passeio

```sql
INSERT INTO tb_passeio (local, data, duracao, valor, tb_agencia_id, tipo, situacao) VALUES
('Paraty - RJ', '2025-07-10', '04:00:00', 150.00, 1, 'normal', 'disponível'),
('Chapada Diamantina', '2025-09-15', '08:00:00', 300.00, 2, 'especial', 'disponível');
```

### tb_atividade

```sql
INSERT INTO tb_atividade (localidade, situacao, nome, descricao) VALUES
('Trilha Ecológica', 'disponível', 'Caminhada', 'Trilha com guia local'),
('Rio Paraíba', 'disponível', 'Rafting', 'Descida de rio com botes');
```

### tb_reserva

```sql
INSERT INTO tb_reserva (data_inicio, data_fim, valor_total, tb_usuario_id, tb_passeio_id) VALUES
('2025-07-10', '2025-07-10', 150.00, 1, 1),
('2025-09-15', '2025-09-15', 300.00, 1, 2);
```

### tb_avaliacao

```sql
INSERT INTO tb_avaliacao (escala, sugestao, tb_usuario_id, tb_agencia_id, tb_passeio_id) VALUES
('5', 'Passeio incrível e bem organizado!', 1, 1, 1),
('4', 'Muito bom, mas poderia incluir lanche.', 1, 2, 2);
```

### tb_passeio_has_tb_atividade

```sql
INSERT INTO tb_passeio_has_tb_atividade (tb_passeio_id, tb_passeio_tb_agencia_id, tb_atividade_id) VALUES
(1, 1, 1),
(2, 2, 2);
```

### tb_usuario_has_tb_passeio

```sql
INSERT INTO tb_usuario_has_tb_passeio (tb_usuario_id, tb_passeio_id, tb_passeio_tb_agencia_id) VALUES
(1, 1, 1),
(1, 2, 2);
```
