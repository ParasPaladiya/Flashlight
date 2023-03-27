import 'package:flashlight/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingeScreen extends StatefulWidget {
  const SettingeScreen({Key? key}) : super(key: key);

  @override
  State<SettingeScreen> createState() => _SettingeScreenState();
}

class _SettingeScreenState extends State<SettingeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("COLOUR CUSTOMIZATION",
                style: TextStyle(color: Colors.blue, fontSize: 14)),
            SettingListTile(press: () {}, titel: "Customize colors (Locked)"),
            SettingListTile(press: () {}, titel: "Customize widgets colors"),
            const Divider(),
            const SizedBox(height: 20),
            const Text("GENERAL",
                style: TextStyle(color: Colors.blue, fontSize: 14)),
            SettingListTile(press: () {}, titel: "Purchase Simple Thank you "),
            CheckboxListTile(
              value: controller.isCheck.value,
              onChanged: (val) {
                setState(() {
                  controller.isCheck.value = val!;
                });
              },
              title: const Text("Turn flashlight on at startup"),
            ),
            CheckboxListTile(
              value: controller.isCheck1.value,
              onChanged: (val) {
                setState(() {
                  controller.isCheck1.value = val!;
                });
              },
              title: const Text("Force portrait mode"),
            ),
            CheckboxListTile(
              value: controller.isCheck2.value,
              onChanged: (val) async {
                setState(() {
                  controller.isCheck2.value = val!;
                });
              },
              title: const Text("Show an SoS button"),
            ),
            CheckboxListTile(
              value: controller.isCheck3.value,
              onChanged: (val) async {
                setState(() {
                  controller.isCheck3.value = val!;
                });
              },
              title: const Text("Show a stroboscope button"),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingListTile extends StatelessWidget {
  const SettingListTile({Key? key, required this.press, required this.titel})
      : super(key: key);

  final VoidCallback? press;
  final String titel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        onTap: press,
        title: Text(titel),
      ),
    );
  }
}

class ChechBoxTile extends StatelessWidget {
  const ChechBoxTile(
      {Key? key,
      required this.onchange,
      required this.titel,
      required this.value,
      required this.checkboxListTile})
      : super(key: key);

  final VoidCallback onchange;
  final String titel;
  final bool value;
  final CheckboxListTile checkboxListTile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: CheckboxListTile(
        onChanged: (val) {
          onchange;
        },
        value: value,
        title: Text(
          titel,
          style: const TextStyle(),
        ),
      ),
    );
  }
}
