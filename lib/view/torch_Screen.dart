import 'dart:async';
import 'dart:math' as math;

import 'package:battery_plus/battery_plus.dart';
import 'package:flashlight/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:torch_light/torch_light.dart';

class TorchScreen extends StatefulWidget {
  const TorchScreen({Key? key}) : super(key: key);

  @override
  State<TorchScreen> createState() => _TorchScreenState();
}

class _TorchScreenState extends State<TorchScreen> {
  HomeController controller = Get.put(HomeController());

  final Battery _battery = Battery();
  int percentage = 0;

  BatteryState batteryState = BatteryState.full;
  late StreamSubscription streamSubscription;

  void getBatteryPerentage() async {
    final level = await _battery.batteryLevel;
    percentage = level;

    setState(() {});
  }

  // method to know the state of the battery
  void getBatteryState() {
    streamSubscription = _battery.onBatteryStateChanged.listen((state) {
      batteryState = state;

      setState(() {});
    });
  }

  bool _isFlashing = false;
  bool _ison = false;

  void _torchon() {
    setState(() {
      _ison = true;
      TorchLight.enableTorch();
    });
  }

  void _torchoff() {
    setState(() {
      _ison = false;
      TorchLight.disableTorch();
    });
  }

  void _startSOS() {
    setState(() {
      _isFlashing = true;
      _flashSOS();
    });
  }

  void _stopSOS() {
    setState(() {
      _isFlashing = false;
      TorchLight.disableTorch();
    });
  }

  void _flashSOS() {
    if (!_isFlashing) return;

    List<int> sosPattern = [
      500,
      500,
      500,
      500,
      1000,
      1000,
      1000,
      500,
      500,
      500
    ];
    int idx = 0;
    Timer.periodic(Duration(milliseconds: sosPattern[idx]), (timer) {
      if (!_isFlashing) {
        timer.cancel();
        return;
      }

      if (idx < sosPattern.length) {
        if (idx % 2 == 0) {
          TorchLight.enableTorch();
        } else {
          TorchLight.disableTorch();
        }
        idx++;
      } else {
        timer.cancel();
        TorchLight.disableTorch();
        _flashSOS();
      }
    });
  }

  static const List<String> states = [
    'off',
    'onn',
  ];

  String state = states.first;

  late ShakeDetector detector;

  bool isClick = false;
  bool soson = false;
  bool torchon = false;
  double val = 1.0;

  @override
  void initState() {
    super.initState();

    getBatteryState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      getBatteryPerentage();
    });

    detector = ShakeDetector.autoStart(onPhoneShake: () {
      final newstate = (List.of(states)
            ..remove(state)
            ..shuffle())
          .first;

      setState(
        () {
          this.state = newstate;
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("F L A S H L I G H T"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/setting_screen');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                      angle: 90 * math.pi / 180,
                      child: BatteryBuild(batteryState)),
                  Text("$percentage%"),
                ],
              ),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff232021),
                      Color(0xff0D0D0F),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(80),
                  border: Border.all(color: Colors.blue.shade400, width: 4),
                ),
                child: IconButton(
                  onPressed: _ison ? _torchoff : _torchon,
                  icon: Icon(
                    Icons.power_settings_new,
                    size: 50,
                    color: Colors.blue.shade400,
                  ),
                ),
              ),
              const Text("Please Shake your phone 📳"),
              TextButton(
                onPressed: null,
                child: Image.asset(
                  state == 'off'
                      ? (() {
                          TorchLight.disableTorch();
                          return 'assets/images/flashlight.png';
                        }())
                      : (() {
                          TorchLight.enableTorch();
                          return 'assets/images/flashlight (2).png';
                        }()),
                  height: 50,
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black26,
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.black))),
                onPressed: _isFlashing ? _stopSOS : _startSOS,
                icon: const Icon(Icons.bolt_sharp),
                label: const Text("SoS"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BatteryBuild(BatteryState state) {
    switch (state) {

      // first case is for battery full state
      // then it will show green in color
      case BatteryState.full:
        // ignore: sized_box_for_whitespace
        return Container(
          width: 40,
          height: 40,

          // ignore: prefer_const_constructors
          child: (Icon(
            Icons.battery_full,
            size: 30,
            color: Colors.green,
          )),
        );

      // Second case is when battery is charging
      // then it will show blue in color
      case BatteryState.charging:

        // ignore: sized_box_for_whitespace
        return Container(
          width: 40,
          height: 40,

          // ignore: prefer_const_constructors
          child: (Icon(
            Icons.battery_charging_full,
            size: 30,
            color: Colors.blue,
          )),
        );

      case BatteryState.discharging:
      default:

        // ignore: sized_box_for_whitespace
        return Container(
          width: 40,
          height: 40,

          // ignore: prefer_const_constructors
          child: (Icon(
            Icons.battery_alert,
            size: 30,
            color: Colors.red,
          )),
        );
    }
  }
}
