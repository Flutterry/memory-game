import 'dart:async';
import 'dart:math';

import 'package:memory_game/src/application.dart';
import 'package:memory_game/src/screen/home/local_model/cell.dart';

class HomeProvider extends ChangeNotifier {
  Timer? timer;
  int timerSeconds = 15;

  HomeProvider() {
    _startGame();
  }

  void _startGame() {
    timer?.cancel();
    timerSeconds = 15;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerSeconds--;
      if (timerSeconds <= 0) {
        timer.cancel();
        for (var i = 0; i < cells.length; i++) {
          cells[i].isShown = false;
          cells[i].clickable = true;
          Future.delayed(Duration(milliseconds: i * 100), () {
            cells[i].controller
              ?..reset()
              ..forward();
          });
        }
        timerSeconds = 3 * 60;
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          timerSeconds--;
          notifyListeners();
          if (timerSeconds <= 0) {
            timer.cancel();
            showResultDialog();
          }
        });
      }
      notifyListeners();
    });
  }

  void showResultDialog() {
    final total = cells.length ~/ 2;
    final score = cells.where((e) => !e.clickable).length ~/ 2;

    showDialog(
        barrierDismissible: false,
        context: ContextService.context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Result'),
            content: Text('Your Score Is $score/$total'),
            actions: [
              TextButton(
                onPressed: () {
                  cells.shuffle();
                  for (final cell in cells) {
                    cell.isShown = true;
                    cell.clickable = false;
                    cell.controller
                      ?..reset()
                      ..forward();
                  }
                  _startGame();
                  pop();
                },
                child: const Text('Restart'),
              )
            ],
          );
        });
  }

  final cells = [
    Cell(getImage('animals/beaver.svg')),
    Cell(getImage('animals/bird.svg')),
    Cell(getImage('animals/butterfly.svg')),
    Cell(getImage('animals/camel.svg')),
    Cell(getImage('animals/cat.svg')),
    Cell(getImage('animals/cow.svg')),
    Cell(getImage('animals/dog.svg')),
    Cell(getImage('animals/elefante.svg')),
    Cell(getImage('animals/escarabajo.svg')),
    Cell(getImage('animals/jirafa.svg')),
    Cell(getImage('animals/rana.svg')),
    Cell(getImage('animals/rooster.svg')),
    Cell(getImage('animals/tigre.svg')),
    Cell(getImage('animals/tropical-fish.svg')),
    Cell(getImage('animals/zebra.svg')),
    Cell(getImage('animals/beaver.svg')),
    Cell(getImage('animals/bird.svg')),
    Cell(getImage('animals/butterfly.svg')),
    Cell(getImage('animals/camel.svg')),
    Cell(getImage('animals/cat.svg')),
    Cell(getImage('animals/cow.svg')),
    Cell(getImage('animals/dog.svg')),
    Cell(getImage('animals/elefante.svg')),
    Cell(getImage('animals/escarabajo.svg')),
    Cell(getImage('animals/jirafa.svg')),
    Cell(getImage('animals/rana.svg')),
    Cell(getImage('animals/rooster.svg')),
    Cell(getImage('animals/tigre.svg')),
    Cell(getImage('animals/tropical-fish.svg')),
    Cell(getImage('animals/zebra.svg')),
  ]..shuffle();

  get timerText =>
      '${(timerSeconds ~/ 60).toString().padLeft(2, '0')}:${(timerSeconds % 60).toString().padLeft(2, '0')}';

  Iterable<Cell> get shownCell =>
      cells.where((element) => element.isShown && element.clickable);

  void onCellTap(Cell cell) {
    if (!cell.clickable) return;

    cell.isShown = !cell.isShown;
    cell.controller
      ?..reset()
      ..forward();

    if (cell.isShown && shownCell.containTwoOf(cell)) {
      shownCell.where((e) => e.image == cell.image).forEach((element) {
        element.clickable = false;
      });
    } else {
      shownCell.where((e) => e.clickable && e != cell).forEach(
        (cell) {
          Future.delayed(const Duration(milliseconds: 500), () {
            cell.isShown = false;
            cell.controller
              ?..reset()
              ..forward();
            notifyListeners();
          });
        },
      );
    }

    notifyListeners();

    if (cells.where((element) => element.clickable).isEmpty) {
      timer?.cancel();
      showResultDialog();
    }
  }
}

extension on Iterable<Cell> {
  bool containTwoOf(Cell cell) {
    return where((element) => element.image == cell.image).length == 2;
  }
}
