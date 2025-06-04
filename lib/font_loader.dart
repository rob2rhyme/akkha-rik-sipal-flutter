// lib/font_loader.dart

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle, FontLoader;
import 'package:flutter/foundation.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/api.dart';
import 'package:crypto/crypto.dart';

/// Derives a 32‐byte AES key from the passphrase (SHA‐256).
Uint8List _deriveKey(String passphrase) {
  final hash = sha256.convert(utf8.encode(passphrase)).bytes;
  return Uint8List.fromList(hash);
}

/// Decrypts the encrypted font blob (AES‐256‐CBC with a zero IV).
Future<ByteData> _decryptFont(Uint8List encrypted, String passphrase) async {
  final keyBytes = _deriveKey(passphrase);
  final iv = Uint8List(16); // 16 zero bytes

  final cipher = CBCBlockCipher(AESFastEngine())
    ..init(false, ParametersWithIV(KeyParameter(keyBytes), iv));

  final out = Uint8List(encrypted.length);
  for (var offset = 0; offset < encrypted.length; offset += cipher.blockSize) {
    cipher.processBlock(encrypted, offset, out, offset);
  }
  return ByteData.view(out.buffer);
}

/// Loads, decrypts, and registers your Akkha‐Lipi font under “GurbachhanAkkhaLipi”.
// Future<void> loadAkkhaFont() async {
//   try {
//     final encData = await rootBundle.load(
//       'assets/fonts/Akkha-Rika-Lipi.ttf.enc',
//     );
//     final encryptedBytes = encData.buffer.asUint8List();

//     const passphrase = String.fromEnvironment('AKKHA_FONT_KEY');
//     if (passphrase.isEmpty) {
//       throw Exception('AKKHA_FONT_KEY not set');
//     }

//     final fontData = await _decryptFont(encryptedBytes, passphrase);

//     final loader = FontLoader('GurbachhanAkkhaLipi')
//       ..addFont(Future.value(fontData));
//     await loader.load();
//   } catch (e, st) {
//     debugPrint('⚠️ loadAkkhaFont failed: $e\n$st');
//   }
// }
Future<void> loadAkkhaFont() async {
  try {
    final encData = await rootBundle.load(
      'assets/fonts/akkha/Akkha-Rika-Lipi.ttf.enc',
    );
    final encryptedBytes = encData.buffer.asUint8List();

    const passphrase = String.fromEnvironment('AKKHA_FONT_KEY');
    debugPrint('AKKHA_FONT_KEY=$passphrase');
    print('AKKHA_FONT_KEY=$passphrase');
    debugPrint('Encrypted bytes length: ${encryptedBytes.length}');
    print('Encrypted bytes length: ${encryptedBytes.length}');

    if (passphrase.isEmpty) {
      throw Exception('AKKHA_FONT_KEY not set');
    }

    final fontData = await _decryptFont(encryptedBytes, passphrase);
    debugPrint('Decrypted font bytes length: ${fontData.lengthInBytes}');
    print('Decrypted font bytes length: ${fontData.lengthInBytes}');

    final loader = FontLoader('GurbachhanAkkhaLipi')
      ..addFont(Future.value(fontData));
    await loader.load();
    debugPrint('✅ FontLoader completed (font registered!)');
  } catch (e, st) {
    debugPrint('⚠️ loadAkkhaFont failed: $e\n$st');
  }
  print('✅ FontLoader completed');
}
