package utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashUtil {

	public static String hashSenha(String senha) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] hashBytes = md.digest(senha.getBytes());

			// Converte os bytes para uma String hexadecimal
			StringBuilder sb = new StringBuilder();
			for (byte b : hashBytes) {
				sb.append(String.format("%02x", b));
			}

			return sb.toString();

		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("Erro ao gerar hash da senha", e);
		}
	}

	// Comparação simples (hash de entrada com hash salvo)
	public static boolean verificarSenha(String senhaDigitada, String senhaHashSalva) { // a senha hash salva vai ser dado apos a busca por email
		return hashSenha(senhaDigitada).equals(senhaHashSalva);
	}
}
