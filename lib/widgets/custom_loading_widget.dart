import 'package:hindustane_ecommerce/AppConfig/app_config.dart';
import 'package:hindustane_ecommerce/utils/styles.dart';
import 'package:hindustane_ecommerce/widgets/animate_widget/elasticIn.dart';
import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatefulWidget {
  const CustomLoadingWidget({Key key}) : super(key: key);

  @override
  _CustomLoadingWidgetState createState() => _CustomLoadingWidgetState();
}

class _CustomLoadingWidgetState extends State<CustomLoadingWidget>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      manualTrigger: false,
      animate: true,
      infinite: true,
      child: CircleAvatar(
        foregroundColor: AppStyles.pinkColor,
        backgroundColor: AppStyles.pinkColor,
        radius: 30,
        child: Container(
          child: Image.asset(
            AppConfig.appLogo,
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}
