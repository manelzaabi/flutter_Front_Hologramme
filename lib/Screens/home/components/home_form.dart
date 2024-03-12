import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Login/login_screen.dart';
import 'package:http/http.dart' as http;

class homeForm extends StatefulWidget {
  const homeForm({Key? key}) : super(key: key);

  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<homeForm> {
  bool _isWifiEnabled = false;
  bool _isCameraEnabled = false;
  bool _isMicroEnabled = false;
  double _volume = 50.0;

  // Function to toggle Wi-Fi
  void _toggleWifi() async {
    final response = await http.post(Uri.parse('http://192.168.211.1:9090/${_isWifiEnabled ? 'deactivate-wifi' : 'activate-wifi'}'));
    if (response.statusCode == 200) {
      setState(() {
        _isWifiEnabled = !_isWifiEnabled;
      });
    } else {
      print('Failed to toggle Wi-Fi');
    }
  }

  // Function to toggle Camera
  void _toggleCamera() async {
    final response = await http.post(Uri.parse('http://192.168.211.1:9090/${_isCameraEnabled ? 'disable-camera' : 'enable-camera'}'));
    if (response.statusCode == 200) {
      setState(() {
        _isCameraEnabled = !_isCameraEnabled;
      });
    } else {
      print('Failed to toggle Camera');
    }
  }

  // Function to toggle Microphone
  void _toggleMicro() async {
    final response = await http.post(Uri.parse('http://192.168.211.1:9090/${_isMicroEnabled ? 'deactivate-microphone' : 'activate-microphone'}'));
    if (response.statusCode == 200) {
      setState(() {
        _isMicroEnabled = !_isMicroEnabled;
      });
    } else {
      print('Failed to toggle Microphone');
    }
  }

  // Function to set Volume
  void _setVolume(double value) async {
    final response = await http.post(Uri.parse('http://192.168.211.1:9090/set-volume'), body: {'volume': value.toString()});
    if (response.statusCode == 200) {
      setState(() {
        _volume = value;
      });
    } else {
      print('Failed to set Volume');
    }
  }

  // Function to handle logout
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: _toggleWifi,
                child: Text(_isWifiEnabled ? 'Disable Wi-Fi' : 'Enable Wi-Fi'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _toggleCamera,
                child: Text(_isCameraEnabled ? 'Disable Camera' : 'Enable Camera'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _toggleMicro,
                child: Text(_isMicroEnabled ? 'Disable Micro' : 'Enable Micro'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Volume',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Slider(
                      value: _volume,
                      activeColor: const Color.fromARGB(255, 189, 17, 5),
                      min: 0,
                      max: 100,
                      divisions: 100,
                      onChanged: _setVolume,
                    ),
                    Text(
                      '${_volume.round()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _logout,
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
