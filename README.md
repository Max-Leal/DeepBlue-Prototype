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
CREATE SCHEMA IF NOT EXISTS deepblue DEFAULT CHARACTER SET utf8;
USE deepblue;

-- USUÁRIO
CREATE TABLE IF NOT EXISTS tb_usuario (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  foto TEXT,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

-- AGÊNCIA
CREATE TABLE IF NOT EXISTS tb_agencia (
  id INT NOT NULL AUTO_INCREMENT,
  nome_empresarial VARCHAR(100) NOT NULL,
  cnpj VARCHAR(18) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  situacao ENUM('disponivel', 'indisponivel') NOT NULL,
  descricao TEXT,
  cep VARCHAR(8),
  telefone VARCHAR(20),
  whatsapp VARCHAR(20),
  instagram VARCHAR(100),
  PRIMARY KEY (id)
) ENGINE=InnoDB;

-- LOCAL (naufrágio)
CREATE TABLE IF NOT EXISTS tb_local (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  localidade VARCHAR(100),
  descricao TEXT,
  tipo_embarcacao varchar(255),
  ano_afundamento INT,
  profundidade DECIMAL(5,2),
  situacao ENUM('disponivel', 'indisponivel') NOT NULL, -- bom para complementar o mapa em filtros
  latitude VARCHAR(255) NOT NULL,
  longitude VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

-- RELAÇÃO N:N ENTRE AGÊNCIA E LOCAL
CREATE TABLE IF NOT EXISTS tb_agencia_local (
  id_agencia INT NOT NULL,
  id_local INT NOT NULL,
  tipo_atividade varchar(255),
  PRIMARY KEY (id_agencia, id_local),
  FOREIGN KEY (id_agencia) REFERENCES tb_agencia(id) ON DELETE CASCADE,
  FOREIGN KEY (id_local) REFERENCES tb_local(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- AVALIAÇÃO (do usuário para agência)
CREATE TABLE IF NOT EXISTS tb_avaliacao_agencia (
  id INT NOT NULL AUTO_INCREMENT,
  escala ENUM('0','1', '2', '3', '4', '5') NOT NULL,
  sugestao TEXT NOT NULL,
  tb_usuario_id INT NOT NULL,
  tb_agencia_id INT NOT NULL,
  data_avaliacao DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (tb_usuario_id) REFERENCES tb_usuario(id) ON DELETE CASCADE,
  FOREIGN KEY (tb_agencia_id) REFERENCES tb_agencia(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- CHAT
CREATE TABLE tb_mensagens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    remetente_id INT NOT NULL,
    remetente_tipo ENUM('usuario', 'agencia') NOT NULL,
    destinatario_id INT NOT NULL,
    destinatario_tipo ENUM('usuario', 'agencia') NOT NULL,
    conteudo TEXT NOT NULL,
    data_envio DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de comentários para locais, com texto e escala (0 a 5)
CREATE TABLE IF NOT EXISTS tb_avaliacao_local (
  id INT NOT NULL AUTO_INCREMENT,
  id_local INT NOT NULL,
  id_usuario INT NOT NULL,
  texto TEXT NOT NULL,
  escala ENUM('0','1','2','3','4','5') NOT NULL,
  data_comentario DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (id_local) REFERENCES tb_local(id) ON DELETE CASCADE,
  FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela para fotos anexas a comentários de locais
CREATE TABLE IF NOT EXISTS tb_avaliacao_foto_local (
  id INT NOT NULL AUTO_INCREMENT,
  id_avaliacao INT NOT NULL,
  url_foto TEXT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_avaliacao) REFERENCES tb_avaliacao_local(id) ON DELETE CASCADE
) ENGINE=InnoDB; 
```
## Inserts para o banco

### tb_usuario

```sql
INSERT INTO tb_usuario (id, nome, email, senha, foto) VALUES
(1, 'Max Augusto Leal da Silva', 'max@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL),
(2, 'Matheus Miguel Samp', 'matheusmiguelsamp@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL),
(3, 'Lucas Antonio', 'lucasantonio@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL);
```

### tb_agencia

```sql
INSERT INTO tb_agencia (id, nome_empresarial, cnpj, email, senha, situacao, descricao, cep, telefone, whatsapp, instagram) VALUES
(1, 'SeaDive', '12.345.678/0001-99', 'seadive@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'disponivel', 'Especialistas em mergulho e aventuras marítimas. Oferecemos certificações PADI, batismos e expedições guiadas para os mais belos naufrágios e recifes da costa. Nossa missão é conectar você ao oceano com segurança e paixão.', '88385000', '47991234567', '47991234567', 'https://www.instagram.com/seadive.aventuras'),
(2, 'Mundo Aventuras', '98.765.432/0001-11', 'mundoaventuras@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'disponivel', 'Sua porta de entrada para a adrenalina e a natureza. Explore trilhas, faça rapel em cachoeiras, navegue de caiaque e mergulhe em locais incríveis. A Mundo Aventuras transforma seu desejo de explorar em realidade.', '88000000', '48988123456', '48988123456', 'https://www.instagram.com/mundo.aventuras.eco');

```

### tb_local

```sql
INSERT INTO tb_local (
  localidade, situacao, nome, descricao, tipo_embarcacao, ano_afundamento, profundidade, latitude, longitude
) VALUES
('Santa Catarina', 'disponivel', 'San Miguel', 'Nau espanhola', 'Nau', NULL, NULL, '-27.58565', '-48.57048'),
('Santa Catarina', 'disponivel', 'Guilhermina', 'Lanchão de nacionalidade desconhecida', 'Lanchão', NULL, NULL, '-27.49565', '-48.53795'),
('Santa Catarina', 'disponivel', 'Sardinha', 'Iate brasileiro', 'Iate', NULL, NULL, '-27.46432', '-48.55442'),
('Santa Catarina', 'disponivel', 'Porto Belgrano', 'Draga argentina', 'Draga', NULL, NULL, '-27.39640', '-48.46408'),
('Santa Catarina', 'disponivel', 'Nome desconhecido', 'Embarcação desconhecida espanhola', 'Desconhecido', NULL, NULL, '-27.43667', '-48.37638'),
('Santa Catarina', 'disponivel', 'Melo II', 'Iate brasileiro', 'Iate', NULL, NULL, '-27.83275', '-48.49828'),
('Santa Catarina', 'disponivel', 'Camponês', 'Iate brasileiro', 'Iate', NULL, NULL, '-27.86057', '-48.57105'),
('Santa Catarina', 'disponivel', 'Marie Charlotte', 'Lúgar francês', 'Lúgar', NULL, NULL, '-27.84892', '-48.57478'),
('Santa Catarina', 'disponivel', 'Nuestra Señora de La Concépcion', 'Nau espanhola', 'Nau', NULL, NULL, '-27.84093', '-48.57023'),
('Santa Catarina', 'disponivel', 'Nome desconhecido', 'Caravela espanhola', 'Caravela', NULL, NULL, '-27.83593', '-48.56422'),
('Santa Catarina', 'disponivel', 'Provedora San Estebán', 'Nau espanhola', 'Nau', NULL, NULL, '-27.82840', '-48.57245'),
('Santa Catarina', 'disponivel', 'Febo', 'Barca italiana', 'Barca', NULL, NULL, '-27.22718', '-48.42557');
```

### tb_mensagens

```sql
INSERT INTO tb_mensagens (remetente_id, remetente_tipo, destinatario_id, destinatario_tipo, conteudo) VALUES
(1, 'usuario', 1, 'agencia', 'Olá, gostaria de saber mais sobre os pacotes disponíveis.'),
(1, 'agencia', 1, 'usuario', 'Claro! Temos promoções especiais neste mês.'),
(2, 'usuario', 2, 'agencia', 'Vocês oferecem pacotes para mergulho em naufrágios?'),
(2, 'agencia', 2, 'usuario', 'Sim! Temos pacotes completos com guia e equipamentos.');

```
