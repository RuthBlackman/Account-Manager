import 'package:account_manger/colours.dart';
import 'package:flutter/material.dart';

class WidgetWithCustomWidth{
  final Widget widget;
  final double? width;

  WidgetWithCustomWidth({
    required this.widget,
    this.width,
  });
}

class MyContainer extends StatelessWidget {
  final List<WidgetWithCustomWidth> children;
  final double height;
  final bool isStarsContainer;
  const MyContainer({Key? key, required this.children, required this.height, required this.isStarsContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        //padding: const EdgeInsets.all(40.0),
      padding: isStarsContainer ? const EdgeInsets.only(left: 40.0, right: 40.0)
          : const EdgeInsets.all(40.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: white,
            ),
            width: 500,
            height: height,
            child: ListView.builder(
              itemCount: children.length,
              itemBuilder: (context, index) {
                final currentChild = children[index];
                // widget is a button, and therefore we need to display a different width
                if(currentChild.width != null){
                  return SizedBox(
                    width: currentChild.width,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        width: currentChild.width,
                        child: currentChild.widget,
                      ),
                    ),
                  );
                  // widget is text, so can have the full width of the container
                }else{
                  return SizedBox(
                    width: currentChild.width,
                    child: currentChild.widget,
                  );
                }
              },
            )
        )
    );
  }
}
