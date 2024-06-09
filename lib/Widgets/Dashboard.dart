import 'package:flutter/material.dart';
import 'package:projtest/Routes/Rally.dart';

class ItemDashBoard extends StatelessWidget {
  final String title, image, button;
  const ItemDashBoard({
    super.key,
    required this.title,
    required this.image,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Image.asset(
              'images/$image',
              height: 200,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '$button');
                },
                child: const Text('More Information'),
              ),
              const SizedBox(width: 25),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok, thanks'),
              )
            ],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                color: Colors.grey.shade300,
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/$image',
              height: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
