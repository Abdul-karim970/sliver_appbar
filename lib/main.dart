import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyCustomScrollView(),
    );
  }
}

class MyCustomScrollView extends StatefulWidget {
  const MyCustomScrollView({super.key});

  @override
  State<MyCustomScrollView> createState() => _MyCustomScrollViewState();
}

class _MyCustomScrollViewState extends State<MyCustomScrollView>
    with SingleTickerProviderStateMixin {
  List<String> widgetsList = [
    'SliverAnimatedGrid',
    'SliverPadding',
    'SliverOpacity',
    'SliverList',
    'SliverGrid',
    'SliverSafeArea',
    'SliverAnimatedList',
    'SliverAnimatedGrid',
    'SliverPadding',
    'SliverOpacity',
    'SliverList',
    'SliverGrid',
    'SliverSafeArea',
    'SliverAnimatedList'
  ];
  List<String> widgetsListSecondary = ['SliverAnimatedList'];
  List<String> widgetListMain = [];
  late AnimationController cont;
  late Animation<double> anim;

  @override
  void initState() {
    super.initState();
    cont =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    anim = Tween<double>(begin: 0, end: 1).animate(cont);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.topCenter,
      child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              onStretchTrigger: () {
                return Future.delayed(
                  const Duration(microseconds: 700),
                  () {
                    if (widgetsListSecondary.length != widgetsList.length) {
                      setState(() {
                        widgetsListSecondary
                            .add(widgetsList[widgetsListSecondary.length]);
                        widgetListMain = widgetsListSecondary.reversed.toList();
                      });
                    } else {
                      setState(() {
                        widgetsListSecondary.removeRange(
                            0, widgetsListSecondary.length);
                        widgetListMain.removeRange(0, widgetListMain.length);
                      });
                    }
                  },
                );
              },
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 200.0,
              backgroundColor: Colors.blue.shade200,
              stretch: true,
              actions: const [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.notification_add_outlined,
                    color: Colors.white,
                  ),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                  title: const Text('Widgets'),
                  centerTitle: true,
                  expandedTitleScale: 1.3,
                  stretchModes: const [
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                    StretchMode.zoomBackground
                  ],
                  background: Image.asset(
                      fit: BoxFit.fill, 'assets/images/flutter.jpeg')),
            ),
            SliverList.builder(
              itemCount: widgetListMain.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(widgetListMain[index]),
                  subtitle: Text('Flutter'),
                  isThreeLine: true,
                  leading: const Icon(
                    Icons.widgets_rounded,
                  ),
                  tileColor: Colors.blue.shade100,
                ),
              ),
            )
          ]),
    ));
  }
}
