
import 'package:url_launcher/url_launcher.dart';

class MapHelper {
  static Future<void> route(String endereco) async {
    final url = Uri.https(
      'www.google.com',
      '/maps/dir/',
      {
        'api': '1',
        'destination': endereco,
      },
    );

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Não foi possível abrir o mapa.');
    }
  }
}
