import 'package:encrypt/encrypt.dart';
import 'package:tafseer/app/assets/constants.dart';

class EncryptionHelper {
  EncryptionHelper._();

  static final EncryptionHelper _instance = EncryptionHelper._();

  static EncryptionHelper get instance => _instance;

  final _encrypter = Encrypter(AES(
    Key.fromUtf8(Constants.cryptoKey),
    mode: AESMode.cbc,
  ));

  static final _iv = IV.fromLength(16);

  String decryption(String value) {
    return _encrypter.decrypt64(value.replaceAll(" ", "+").trim(), iv: _iv);
  }

  String encryption(String value) {
    return _encrypter.encrypt(value, iv: _iv).base64;
  }
}
