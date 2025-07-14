# Protótipo DeepBlue

Este repositório contém o projeto DeepBlue. Siga as instruções abaixo para clonar o repositório e acessar sua própria branch de desenvolvimento.

## 📥 Como clonar o repositório

Acesse o terminal bash no local da pasta do workspace:

![image](https://github.com/user-attachments/assets/ce72545a-5b2d-43a6-9e2a-e1d85036c4c0)


Para obter uma cópia local deste projeto, execute o seguinte comando no terminal:

```bash
git clone https://github.com/Max-Leal/DeepBlue-Prototype.git
```

Não se esqueça de alterar o caminho da pasta, utilizando o seguinte comando no terminal:

```bash
cd DeepBlue-Prototype
```

## 🌿 Como criar e acessar sua própria branch

Para entrar na sua branch para fazer as tarefas use no terminal onde está aberto o projeto:

```bash
git checkout (seu nome)-feature
```


Exemplo: git checkout max-feature

OBS.: Sempre lembrar de fazer um: git pull origin (seu nome)-feature

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
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `tipo` ENUM('admin', 'cliente') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`cpf`),
  UNIQUE (`email`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=armscii8;

CREATE TABLE IF NOT EXISTS `tb_agencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_empresarial` VARCHAR(45) NOT NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `situacao` ENUM('disponivel', 'indisponivel') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`cnpj`),
  UNIQUE (`email`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `tb_local` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `localidade` VARCHAR(45) NOT NULL,
  `situacao` ENUM('disponivel', 'indisponivel') NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `latitude` VARCHAR(255) NOT NULL,   -- latitude vem primeiro
  `longitude` VARCHAR(255) NOT NULL,  -- longitude vem depois
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `tb_avaliacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `escala` ENUM('1', '2', '3', '4', '5') NOT NULL,
  `sugestao` VARCHAR(200) NOT NULL,
  `tb_usuario_id` INT NOT NULL,
  `tb_agencia_id` INT NOT NULL,
  PRIMARY KEY (`id`, `tb_usuario_id`, `tb_agencia_id`),
  FOREIGN KEY (`tb_usuario_id`) REFERENCES `tb_usuario` (`id`),
  FOREIGN KEY (`tb_agencia_id`) REFERENCES `tb_agencia` (`id`)
) ENGINE=InnoDB;
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
('Agência ViagensSol', '12.345.678/0001-99', 'contato@viagenssol.com', 'sol123', 'disponivel'),
('Mundo Aventuras', '98.765.432/0001-11', 'aventura@mundo.com', 'aventura@2024', 'disponivel');
```

### tb_local

```sql
insert into tb_local (localidade, situacao, nome, descricao, latitude, longitude) values
('Santa Catarina', 'disponivel', 'San Miguel', 'Nau espanhola', '-27.58565', '-48.57048'),
('Santa Catarina', 'disponivel', 'Guilhermina', 'Lanchão de nacionalidade desconhecida', '-27.49565', '-48.53795'),
('Santa Catarina', 'disponivel', 'Sardinha', 'Iate brasileiro', '-27.46432', '-48.55442'),
('Santa Catarina', 'disponivel', 'Porto Belgrano', 'Draga argentina', '-27.39640', '-48.46408'),
('Santa Catarina', 'disponivel', 'Nome desconhecido', 'Embarcação desconhecida espanhola', '-27.43667', '-48.37638'),
('Santa Catarina', 'disponivel', 'Melo II', 'Iate brasileiro', '-27.83275', '-48.49828'),
('Santa Catarina', 'disponivel', 'Camponês', 'Iate brasileiro', '-27.86057', '-48.57105'),
('Santa Catarina', 'disponivel', 'Marie Charlotte', 'Lúgar francês', '-27.84892', '-48.57478'),
('Santa Catarina', 'disponivel', 'Nuestra Señora de La Concépcion', 'Nau espanhola', '-27.84093', '-48.57023'),
('Santa Catarina', 'disponivel', 'Nome desconhecido', 'Caravela espanhola', '-27.83593', '-48.56422'),
('Santa Catarina', 'disponivel', 'Provedora San Estebán', 'Nau espanhola', '-27.82840', '-48.57245'),
('Santa Catarina', 'disponivel', 'Febo', 'Barca italiana', '-27,22718', '-48.42557');
```

