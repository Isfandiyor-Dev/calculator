import 'dart:io';

void main(List<String> arguments) {
  stdout.write("Ifoda javobi +: ");
  print(5 + 6 - 5 + 12 - 6);
  stdout.write("Ifoda javobi -: ");
  print(-5 + 6 - 5 + 12 - 6);
  // print(7 + 2 / 4 * (7 + 9 / 3) / 4 * 2 + 1 + (4 + (2 + 3 * 2 + (7 - 2))));

  //my codes
  stdout.write("Ifodani kiriting: ");
  String? response = stdin.readLineSync();

  RegExp regExp = RegExp(r'^[\d\s+\-*/()]+$');
 
  if (response != null && regExp.hasMatch(response)) {
    calculate(response);
  } else {
    print("Iltimos tog'ri ifoda kiriting");
  }
}

void calculate(String response) {
  response = response.replaceAll(" ", "");

  List<String> numbersString = response.split(RegExp(r'[+-/*]'));
  List<String> hints = response.split(RegExp(r'[0-9]'));

  hints.removeWhere((element) => element.trim().isEmpty);
  numbersString.removeWhere((element) => element.trim().isEmpty);

  print(numbersString);
  print(hints);

  List<double> numbers = numbersString
      .map(
        (e) => double.parse(e),
      )
      .toList();

  double sum = 0;

  if (numbers.length == hints.length) {
    for (int i = 0; i < numbers.length; i++) {
      switch (hints[i]) {
        case '+':
          if (!hints[i < numbers.length - 1 ? i + 1 : i]
              .contains(RegExp("[/*]"))) {
            sum += numbers[i];
          }
        case '-':
          if (!hints[i < numbers.length - 1 ? i + 1 : i]
              .contains(RegExp("[/*]"))) {
            sum -= numbers[i];
          }
        case '/':
          switch (hints[i - 1]) {
            case '+':
              sum += numbers[i - 1] / numbers[i];
            case '-':
              sum -= numbers[i - 1] / numbers[i];
            default:
              sum /= numbers[i];
          }
        case '*':
          switch (hints[i - 1]) {
            case '+':
              sum += numbers[i - 1] * numbers[i];
            case '-':
              sum -= numbers[i - 1] * numbers[i];
            default:
              sum *= numbers[i];
          }
        default:
          sum += numbers[i];
      }
    }
  } else {
    for (int i = 0; i < numbers.length; i++) {
      if (i == 0) {
        sum += numbers[i];
        continue;
      }
      switch (hints[i - 1]) {
        case '+':
          if (!hints[i - 1].contains(RegExp("[/*]"))) {
            sum += numbers[i];
          }
        case '-':
          if (!hints[i - 1].contains(RegExp("[/*]"))) {
            sum -= numbers[i];
          }
        case '/':
          switch (hints[i - 1]) {
            case '+':
              sum += numbers[i - 1] / numbers[i];
            case '-':
              sum -= numbers[i - 1] / numbers[i];
            default:
              sum /= numbers[i];
          }
        case '*':
          switch (hints[i - 1]) {
            case '+':
              sum += numbers[i - 1] * numbers[i];
            case '-':
              sum -= numbers[i - 1] * numbers[i];
            default:
              sum *= numbers[i];
          }
        default:
          sum += numbers[i];
      }
    }
  }
  print("Sum: $sum");
}
