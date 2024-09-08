package Controller.EncryptPassword;

import java.nio.charset.StandardCharsets;
import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class EncDyc {
	// Method to encrypt a string using AES encryption
	public static final String algo="AES";
	public static String encryption(String strToEncrypt, String secretKey)throws Exception{
		Key key=generateKey(secretKey);
		Cipher cipher=Cipher.getInstance("AES/ECB/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE,key);
		byte[] encryptedBytes=cipher.doFinal(strToEncrypt.getBytes(StandardCharsets.UTF_8));
		// Convert the encrypted bytes to a string using ISO-8859-1 encoding
		return new String(encryptedBytes, StandardCharsets.ISO_8859_1);
	}
	
	// Method to decrypt an AES encrypted string
	public static String decrypt(String strToDecrypt, String secretKey)throws Exception{
		Key key=generateKey(secretKey);
		Cipher cipher=Cipher.getInstance("AES/ECB/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE,key);
		byte[] encryptedBytes=cipher.doFinal(strToDecrypt.getBytes(StandardCharsets.UTF_8));
		// Convert the decrypted bytes to a string using ISO-8859-1 encoding
		return new String(encryptedBytes, StandardCharsets.ISO_8859_1);
	}
	
	// Method to generate a secret key for AES encryption
	private static Key generateKey(String secretKey) {
		// Convert the secret key to bytes using UTF-8 encoding
		byte [] KeyBytes=secretKey.getBytes(StandardCharsets.UTF_8);
		// Create a SecretKeySpec using the secret key bytes and the AES algorithm
		return new SecretKeySpec(KeyBytes, algo);
	}
}
