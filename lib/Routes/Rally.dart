import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Rally extends StatelessWidget {
  const Rally({super.key});

  static const String screenRoute = 'Rally';

  Container clubContainer(
      {required Color containerColor, required String containerText}) {
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
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Rally',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                  containerColor: Colors.red, containerText: 'Human Resources'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.red, containerText: 'Training'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.red, containerText: 'Development'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.red, containerText: 'Marketing'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.red,
                  containerText: 'Public Relationship'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(containerColor: Colors.red, containerText: 'FR'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.red, containerText: 'Projects'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(containerColor: Colors.red, containerText: 'Media'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.red, containerText: 'Coordination'),
              const SizedBox(
                height: 18,
              ),
              clubContainer(
                  containerColor: Colors.red, containerText: 'Logistics'),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () {},
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
}