import 'package:html_unescape/html_unescape.dart';

htmlDecode(input) {
  var unescape = new HtmlUnescape();
  var text = unescape.convert(input);
  return text;
}
