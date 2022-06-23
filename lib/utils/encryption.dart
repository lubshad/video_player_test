import 'dart:io';
import 'dart:typed_data';

import 'package:basic_template/basic_template.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:video_player_test/domain/entities/video_details.dart';

class EncryptionUtils {
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encrypt.Encrypted encryptAES(Uint8List bytes) {
    final encrypted = encrypter.encryptBytes(bytes, iv: iv);

    // logger.info(encrypted.bytes);
    // logger.info(encrypted.base16);
    // logger.info(encrypted.base64);
    return encrypted;
  }

  static List<int> decryptAES(encrypt.Encrypted data) {
    final decrypted = encrypter.decryptBytes(data, iv: iv);
    // logger.info(decrypted);
    return decrypted;
  }

  static encryptAndSave(Response response, VideoDetails videoDetails) async {
    logger.info("encryption started");
    final appDir = await getExternalStorageDirectory();
    // compute((externalDirPath) async {
    logger.info("encrypting");
    final encrypted = encryptAES(response.bodyBytes);
    final File file = await File("${appDir!.path}/${videoDetails.id!}")
        .create(recursive: true);
    await file.writeAsBytes(encrypted.bytes);
    logger.info("encrypted");
    // }, appDir!.path);
  }

  static Future<File?> decryptDownloadedFile(String fileName) async {
    final appDir = await getExternalStorageDirectory();
    final File file = File("${appDir!.path}/$fileName");
    if (!await file.exists()) return null;

    // final decryptionPort = ReceivePort();
    // await Isolate.spawn((SendPort decryptionSentPort) async {
    logger.info("decrypting");
    Uint8List fileBytes = file.readAsBytesSync();
    List<int> decryptedBytes = decryptAES(encrypt.Encrypted(fileBytes));
    final tempDir = await getTemporaryDirectory();
    final tempVideoFile = File("${tempDir.path}/tempvideo.mp4");
    tempVideoFile.create(recursive: true);
    final decryptedFile = await tempVideoFile.writeAsBytes(decryptedBytes);
    logger.info("decrypted");
    return decryptedFile;
    // Isolate.exit(decryptionSentPort, decryptedFile);
    // }, decryptionPort.sendPort);
    // return await decryptionPort.first as File;
  }
}
