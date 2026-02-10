import 'package:flutter/material.dart';
import 'package:marketing_app/screens/camera_screen.dart';
import 'package:marketing_app/theme/background_scaffold.dart';
import 'package:marketing_app/widgets/screen_headline.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({
    super.key,
    required this.title,
    required this.description,
    required this.steps,
  });

  final String title;
  final String description;
  final List<String> steps;
  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        title: ScreenHeadline(text: "$title - Example"),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 280,
              color: const Color.fromARGB(255, 56, 56, 56),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 100,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20),

            Container(padding: EdgeInsets.all(30), child: Text(description)),

            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE98A57),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
              ),

              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => CameraScreen(steps: steps),
                  ),
                );
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
