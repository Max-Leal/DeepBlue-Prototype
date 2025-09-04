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