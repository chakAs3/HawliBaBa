package com.hawli.model
{
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.symmetric.ICipher;
	import com.hurlant.crypto.symmetric.IPad;
	import com.hurlant.crypto.symmetric.PKCS5;
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;
	
	import flash.utils.ByteArray;

/**
 * @author ©haki®
 */

	public class Cryptage
	{
		public static var key:*;
		public function Cryptage()
		{
		}
		public static function encrypt(txt:String = ''):String
		{
			var type:String='simple-des-ecb';
			var key :ByteArray= Hex.toArray(Hex.fromString(key));
			var data:ByteArray = Hex.toArray(Hex.fromString(txt));
			
			var pad:IPad = new PKCS5;
			var mode:ICipher = Crypto.getCipher(type, key, pad);
			pad.setBlockSize(mode.getBlockSize());
			mode.encrypt(data);
			return Base64.encodeByteArray(data);
		}
		public static function decrypt(txt:String = ''):String
		{
			var type:String='simple-des-ecb';
			var key :ByteArray= Hex.toArray(Hex.fromString(key));
			var data:ByteArray = Base64.decodeToByteArray(txt);
			var pad:IPad = new PKCS5;
			var mode:ICipher = Crypto.getCipher(type, key, pad);
			pad.setBlockSize(mode.getBlockSize());
			mode.decrypt(data);
			return Hex.toString(Hex.fromArray(data));
		}
	}
}