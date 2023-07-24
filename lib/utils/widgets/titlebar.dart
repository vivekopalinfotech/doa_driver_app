import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final title;
  const TitleBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){Navigator.pop(context);},
                  child: const Icon(Icons.arrow_back_ios_new_outlined,size: 22,)),
               Text('    $title',style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          )),
    );
  }
}
