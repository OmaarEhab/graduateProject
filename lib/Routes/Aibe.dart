import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Aibe extends StatelessWidget {
  const Aibe({super.key});

  static const String screenRoute = 'Aibe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Aibe',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Rally Startup is a competition organized by AAST EC and powered by AASTMT for anyone who wants to start their own business. University students and startup founders will have the chance to present and discuss their business ideas with experts from various fields and industries.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              clubContainer(
                  containerColor: Colors.deepPurple, containerText: 'Human Resources'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.deepPurple, containerText: 'Training'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.deepPurple, containerText: 'Development'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.deepPurple, containerText: 'Marketing'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.deepPurple,
                  containerText: 'Public Relationship'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(containerColor: Colors.deepPurple, containerText: 'FR'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.deepPurple, containerText: 'Projects'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(containerColor: Colors.deepPurple, containerText: 'Media'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.deepPurple, containerText: 'Coordination'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.deepPurple, containerText: 'Logistics'),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () {
                  appLaunchUrl(
                    Uri.parse('https://forms.gle/dSeUjktHmCDr6KsP6'),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  width: double.infinity,
                  height: 60,
                  child: const Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      'Apply Now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Container clubContainer({
    required Color containerColor,
    required String containerText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(14),
      ),
      width: double.infinity,
      height: 45,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          containerText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  Future<void> appLaunchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
