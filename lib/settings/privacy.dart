import 'package:grocery_app/constants/app_properties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {

  List<Panel> panels = [
    Panel(
        'Disclosure of Your Personal Data',
        'If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.',
        false),
    Panel(
        'Law enforcement?',
        'Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).',
        false),
    Panel(
        'Other legal requirements',
        'The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:'
        'Comply with a legal obligation'
    'Protect and defend the rights or property of the Company'
    'Prevent or investigate possible wrongdoing in connection with the Service'
    'Protect the personal safety of Users of the Service or the public'
    'Protect against legal liability',
        false),
    Panel(
        'Security of Your Personal Data',
        'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.',
        false),
    Panel(
        'Childrens Privacy',
        'Our Service does not address anyone under the age of 13. We do not knowingly collect '
            'personally identifiable information from anyone under the age of 13. '
            'If You are a parent or guardian and You are aware that Your child has '
            'provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data '
            'from anyone under the age of 13 without verification of parental consent, '
            'We take steps to remove that information from Our servers.'
        'If We need to rely on consent as a legal basis'
       ' for processing Your information and Your country '
    'requires consent from a parent, We may require Your parents consent before We collect and use that information.',
        false),
    Panel(
        'Changes to this Privacy Policy',
        ' We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.'
        'We will let You know via email and/or a prominent notice on Our'
        'Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.'
     'You are advised to review this Privacy Policy periodically for any changes.'
            ' Changes to this Privacy Policy are effective when they are posted on this page.',
        false)
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:24.0,right:24.0,bottom: 16.0),
                child: Text(
                  'FAQ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),... panels.map((panel)=>ExpansionTile(
                  title: Text(
                    panel.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]),
                  ),

                  children: [Container(
                      padding: EdgeInsets.all(16.0),
                      color: Color(0xffFAF1E2),
                      child: Text(
                          panel.content,
                          style:
                          TextStyle(color: Colors.grey, fontSize: 12)))])).toList(),

            ],
          ),
        ),
      ),
    );
  }
}

class Panel {
  String title;
  String content;
  bool expanded;

  Panel(this.title, this.content, this.expanded);
}

