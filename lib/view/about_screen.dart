import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class About_Screen extends StatefulWidget {
  const About_Screen({Key? key}) : super(key: key);

  @override
  State<About_Screen> createState() => _About_ScreenState();
}

class _About_ScreenState extends State<About_Screen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("SUPPORT",
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
              SettingListTile(
                press: () {},
                titel: "Frequently asked question",
                icon: Icons.question_mark_outlined,
              ),
              SettingListTile(
                press: () async {
                  String email =
                      Uri.encodeComponent("paraspaladiya39288@gmail.com");
                  String subject = Uri.encodeComponent(" ");
                  String body = Uri.encodeComponent("");
                  Uri mail =
                      Uri.parse("mailto:$email?subject=$subject&body=$body");
                  if (await launchUrl(mail)) {
                    //email app opened
                  } else {
                    //email app is not opened
                  }
                },
                titel: "paraspaladiya39288@gmail.com",
                icon: Icons.mail,
              ),
              const SizedBox(height: 10),
              const Text("HELP US",
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
              SettingListTile(
                press: () {
                  Share.share(
                      "hi how are you whate your name https://play.google.com/store/apps/details?id=com.example.tranlation_app");
                },
                titel: "Rate us",
                icon: Icons.star_rate,
              ),
              SettingListTile(
                press: () {},
                titel: "Invite friends",
                icon: Icons.person_add_alt_1_rounded,
              ),
              const SizedBox(height: 10),
              const Text("SOCIAL",
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
              SocialListTile(
                press: () {},
                titel: "Facebook",
                image: 'assets/images/facebook.png',
              ),
              SocialListTile(
                press: () async {
                  Uri ok = Uri.parse("https://github.com/ParasPaladiya");
                  if (await launchUrl(ok)) {
                    //email app opened
                  }
                },
                titel: "Github",
                image: 'assets/images/github.png',
              ),
              SocialListTile(
                press: () {},
                titel: "Reddit",
                image: 'assets/images/reddit.png',
              ),
              SocialListTile(
                press: () {},
                titel: "Telegram",
                image: 'assets/images/telegram.png',
              ),
              const Divider(),
              const SizedBox(height: 10),
              const Text("OTHER",
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
              SettingListTile(
                press: () {},
                titel: "Get Simple Phone",
                icon: Icons.phone_android,
              ),
              SettingListTile(
                press: () {},
                titel: "More apps from us",
                icon: Icons.share,
              ),
              SettingListTile(
                press: () {},
                titel: "Privacy policy",
                icon: Icons.visibility,
              ),
              SettingListTile(
                press: () {},
                titel: "Third party licences",
                icon: Icons.privacy_tip,
              ),
              SettingListTile(
                press: () {},
                titel: 'Version ${_packageInfo.version}',
                icon: Icons.info_rounded,
              ),
              const Divider(),
              const SizedBox(height: 10),
              const Center(
                  child: Text(
                "Made with ❤ in Codewing",
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingListTile extends StatelessWidget {
  const SettingListTile(
      {Key? key, required this.press, required this.icon, required this.titel})
      : super(key: key);

  final VoidCallback press;
  final String titel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(onTap: press, title: Text(titel), leading: Icon(icon)),
    );
  }
}

class SocialListTile extends StatelessWidget {
  const SocialListTile(
      {Key? key, required this.press, required this.image, required this.titel})
      : super(key: key);

  final VoidCallback press;
  final String titel, image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        onTap: press,
        title: Text(titel),
        leading: Image.asset(
          image,
          height: 30.0,
        ),
      ),
    );
  }
}
