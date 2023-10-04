import 'package:flutter/material.dart';

import 'package:times_up_flutter/utils/app_strings.dart';

class Keys {
  static const emailKeys = Key('emailLoginKey');
  static const geoFullKeys = Key('geoFullKey');
  static const googleMapKeys = Key('googleMaplKey');
}

class EmailConstants {
  static const subject = "Time's up - Welcome email";
  static const text = '';

  static const welcomeHeaderText = 'Welcome to ${Strings.appName}';
  static const logoImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/demooo-6e52b.appspot.com/o/time%2Foutput-onlinepngtools.png?alt=media&token=5755f1a1-4576-43c7-a542-04860361404d&_gl=1*1jyiwv9*_ga*NjE3NTkxMTQ2LjE2ODY1ODAyODg.*_ga_CW55HF8NVT*MTY5NjMzMTY4NC45NC4xLjE2OTYzMzQ0MjguMzguMC4w.jpg';
  static const giphyCode = '''
''';
//   '''
// <div style="padding-top:75.000%;position:relative;"><iframe src="https://firebasestorage.googleapis.com/v0/b/demooo-6e52b.appspot.com/o/time%2Fezgif.com-optimize%20(1).gif?alt=media&token=24a48377-78a2-4da8-bfda-a9be4f01f4d9&_gl=1*1i9c6ta*_ga*NjE3NTkxMTQ2LjE2ODY1ODAyODg.*_ga_CW55HF8NVT*MTY5NjMzMTY4NC45NC4xLjE2OTYzMzc5MDUuNTMuMC4w" width="100%" height="100%" style='position:absolute;top:0;left:0;' frameBorder="0" allowFullScreen></iframe></div><p><a href="https://gifer.com">via GIFER</a></p>
// ''';

  static const body = '''
        <p>We are thrilled to have you as a new member of our community. Your presence means a lot to us!</p>
        <p>Thank you for joining us!</p>
        <p>Best regards,</p>
        <p>Time's up Team</p>''';

  static const style = '''
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #3A4EDC; /* Set the background color to #3A4EDC */
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
        }
        .header {
            text-align: center;
            padding: 20px 0;
        }
        h1 {
            color: #333;
        }
        p {
            color: #666;
        }
        .logo {
            display: block;
            margin: 0 auto;
            width: 200px;
            border-radius: 6px;
        }
        .giphy {
            text-align: center;
        }
    </style>

  ''';

  // ignore: leading_newlines_in_multiline_strings
  static String html(String username) => ''' 
  <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${EmailConstants.welcomeHeaderText}</title>
    ${EmailConstants.style}
</head>
<body>
    <div class="container">
        <div class="header">
            <img class="logo" src=${EmailConstants.logoImageUrl} alt="Welcome Logo">
        </div>
        <h1>${EmailConstants.welcomeHeaderText}</h1>
        
        
        <div class="giphy">
            $giphyCode
        </div>
        <p>Dear $username,</p>
        ${EmailConstants.body}
    </div>
</body>
</html>
''';
}
