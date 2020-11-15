import 'package:url_launcher/url_launcher.dart';

Future<bool> launchEmail(String email, String subject, String body) {
  Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': subject, 'body': body});

  return launchURL(emailLaunchUri.toString());
}

Future<bool> launchURL(String url) async {
  if (await canLaunch(url)) {
    return await launch(url);
  } else {
    return false;
  }
}
