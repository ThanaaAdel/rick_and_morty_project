import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/app_router.dart';

void main() {
  runApp( BreakinBadApp(appRouter: AppRouter(),));
}

class BreakinBadApp extends StatelessWidget {
final AppRouter appRouter;

  const BreakinBadApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      
    );
  }
}

