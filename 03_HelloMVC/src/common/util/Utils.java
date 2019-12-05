package common.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class Utils {
	
	/**
	 * 		  <= 불가능
	 * "abcd" => "aehuewfhweuafhlwv09==="
	 * 단방향 알고리즘
	 * 
	 * sha512알고리즘을 이용한 암호화
	 * 1. 암호화
	 * 2. 인코딩
	 * 
	 * @param password
	 * @return
	 */
	public static String getSha512(String password) {
		String encPwd = null;
		
		MessageDigest md = null;
		
		try {
			//md5, sha-1, sha-256, sha-384, sha-512		숫자가 높을 수록 보안성이 뛰어남.
			md = MessageDigest.getInstance("sha-512");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//문자열 => 바이트배열로 변환
		byte[] bytes = null;
		
		try {
			bytes = password.getBytes("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		//md객체에 바이트배열 전달
		md.update(bytes);
		
		//해싱함수를 이용한 암호화
		byte[] encBytes = md.digest();
		System.out.println(">> 암호화 후 인코딩 전 : "+new String(encBytes));
		
		//2. 인코딩 (64개 문자로 표현 : 대문자/소문자 52개 + 숫자 10개 + / 패딩문자 =
		encPwd = Base64.getEncoder().encodeToString(encBytes);
		
		return encPwd;
	}
}
