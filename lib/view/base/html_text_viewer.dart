import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' show parse;

class HtmlTextViewerWidget extends StatelessWidget {
  const HtmlTextViewerWidget({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    /// Clean text from unsupported math equations like (×, <, >, ...etc)
    final mathRegex = RegExp(
      r'<math\s+(?:.*?)?class="wrs_chemistry"(?:.*?)?>\s*(?:<mo>|<mi\s+.*?>)&#(\d+);</(?:mo|mi)>\s*</math>',
    );

    const replacements = {
      '215': '×',
      '177': '±',
      '62': '>',
      '60': '<',
      '8722': '−',
      '247': '÷',
      '8805': '≥',
      '8804': '≤',
      '8712': '∈',
      '8715': '∋',
      '960': 'π',
    };

//     const text2 = '''<h3><strong><span dir="RTL">اي مما يأتي يعبر عن كل من عدد الالكترونات الحره وعدد الكترونات الارتباط في ذره الفوسفور </span>P<sub>15</sub> في مركب PCl<sub>3</sub> ؟&hellip;&hellip;&hellip;&hellip;..</strong></h3>
//
// <h3>&nbsp;</h3>
//
// <table align="right" cellspacing="0" style="border-collapse:collapse">
// 	<tbody>
// 		<tr>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:1px solid black; vertical-align:top;">
// 			<h3>الاختبارات</h3>
// 			</td>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:none; border-top:1px solid black; vertical-align:top;">
// 			<h3>عدد الالكترونات الحره</h3>
// 			</td>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:none; border-top:1px solid black; vertical-align:top;">
// 			<h3>عدد الكترونات الارتباط</h3>
// 			</td>
// 		</tr>
// 		<tr>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; vertical-align:top;">
// 			<h3>أ</h3>
// 			</td>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:none; border-top:none; vertical-align:top;">
// 			<h3><span dir="LTR">1</span></h3>
// 			</td>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:none; border-top:none; vertical-align:top;">
// 			<h3><span dir="LTR">3</span></h3>
// 			</td>
// 		</tr>
// 		<tr>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; vertical-align:top;">
// 			<h3>ب</h3>
// 			</td>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:none; border-top:none; vertical-align:top;">
// 			<h3><span dir="LTR">2</span></h3>
// 			</td>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:none; border-top:none; vertical-align:top;">
// 			<h3><span dir="LTR">6</span></h3>
// 			</td>
// 		</tr>
// 		<tr>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; vertical-align:top;">
// 			<h3>ج</h3>
// 			</td>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:none; border-top:none; vertical-align:top;">
// 			<h3><span dir="LTR">2</span></h3>
// 			</td>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:none; border-top:none; vertical-align:top;">
// 			<h3><span dir="LTR">3</span></h3>
// 			</td>
// 		</tr>
// 		<tr>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; vertical-align:top;">
// 			<h3>د</h3>
// 			</td>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:none; border-top:none; vertical-align:top;">
// 			<h3><span dir="LTR">4</span></h3>
// 			</td>
// 			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:none; border-top:none; vertical-align:top;">
// 			<h3><span dir="LTR">4</span></h3>
// 			</td>
// 		</tr>
// 	</tbody>
// </table>
//
// <h3>أ</h3>
//
// <table align="center" cellpadding="1" cellspacing="1" style="border-collapse:collapse">
// 	<tbody>
// 		<tr>
// 			<td>بسم الله</td>
// 			<td>بسم الله</td>
// 		</tr>
// 		<tr>
// 			<td>مرحبا</td>
// 			<td>مرحبا</td>
// 		</tr>
// 		<tr>
// 			<td>أهلا</td>
// 			<td>أهلا</td>
// 		</tr>
// 	</tbody>
// </table>
//
// <p>&nbsp;</p>
//
// ''';
//
//     return Html(
//       data: "<h3>$text2</h3>",
//       style: textStyle != null ? {
//         "h3": Style.fromTextStyle(textStyle!).copyWith(
//           margin: const EdgeInsets.all(-9),
//         ),
//       } : {},
//       shrinkWrap: true,
//     );

    final htmlText = text.replaceAllMapped(mathRegex, (match) {
      final captured = match.group(1);
      final replacement = replacements[captured];
      debugPrint('- Replacements were made');
      return replacement ?? match.group(0) ?? ''; // replace or keep the original
    });


    /// Split html text string by lines, each line has its own Directionality.
    /// Then return as List<Widget>.
    final lines = htmlText.split(RegExp(r'\n|<br>'));
    // remove all empty lines
    lines.removeWhere((element) => parse(element).documentElement!.text.isEmpty);
    final List<Widget> children = lines.map((line) {
      /// Parse the current line to get plain text from html string.
      ///
      /// That helps to detect Directionality of text based on first character of parsedLine text.
      final parsedLine = parse(line).documentElement!.text;

      // Get first char in the parsed line which is not number or a space
      final notNumberOrWhitespaceRegEx = RegExp(r'[^\w\s*+×<>]');
      final match = notNumberOrWhitespaceRegEx.firstMatch(parsedLine);
      final firstChar = match?.group(0)??'';
      final isRtl = firstChar.startsWith(RegExp(r'[\u0600-\u06FF]'));

      // debugPrint('-----------');
      // debugPrint('html line: $line');
      // debugPrint('parsed line: "$parsedLine"');
      // debugPrint('first char match regex: "$firstChar"');
      // debugPrint('is RTL: $isRtl');
      // debugPrint('-----------');

      return Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: Html(
          data: "<h3>$line</h3>",
          style: textStyle != null ? {
            "h3": Style.fromTextStyle(textStyle!).copyWith(
              margin: const EdgeInsets.all(-9),
            ),
          } : {},
          shrinkWrap: false,
        ),
      );
    }).toList();

    return Column(
      children: children,
    );
  }
}
