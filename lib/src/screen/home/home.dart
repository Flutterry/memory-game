import 'package:flutter_svg/svg.dart';
import 'package:memory_game/src/application.dart';
import 'package:memory_game/src/screen/home/local_model/cell.dart';
import 'package:memory_game/src/screen/home/local_widget/game_cell.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<HomeProvider>();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              getImage('animals/bg-home.svg'),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20,
            right: 0,
            left: 0,
            child: CustomText(
              text: provider.timerText,
              fontSize: 50,
              align: TextAlign.center,
            ),
          ),
          Center(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 5,
              children: provider.cells.map((cell) => GameCell(cell)).toList(),
            ),
          )
        ],
      ),
    );
  }
}
