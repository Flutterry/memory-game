import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memory_game/src/application.dart';
import 'package:memory_game/src/screen/home/local_model/cell.dart';

class GameCell extends StatelessWidget {
  final Cell cell;
  const GameCell(this.cell, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<HomeProvider>().onCellTap(cell),
      child: FlipInX(
        controller: (p0) => cell.controller = p0,
        manualTrigger: true,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(4),
          width: Cell.width,
          height: Cell.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 5),
            ],
          ),
          child: cell.isShown
              ? SvgPicture.asset(cell.image)
              : const Icon(
                  Icons.star,
                  color: Colors.blue,
                  size: 45,
                ),
        ),
      ),
    );
  }
}
