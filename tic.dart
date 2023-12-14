import 'dart:io';

class TicTacToe {
  List<List<String>> board;
  String currentPlayer;

  TicTacToe() {
    board = List.generate(3, (_) => List.generate(3, (_) => ' '));
    currentPlayer = 'X';
  }

  void printBoard() {
    for (var row in board) {
      print(row.join(' | '));
      print('---------');
    }
  }

  bool makeMove(int row, int col) {
    if (row < 0 || row >= 3 || col < 0 || col >= 3 || board[row][col] != ' ') {
      print('Invalid move. Try again.');
      return false;
    }

    board[row][col] = currentPlayer;
    return true;
  }

  bool checkWin() {
    // Check rows and columns
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer && board[i][1] == currentPlayer && board[i][2] == currentPlayer ||
          board[0][i] == currentPlayer && board[1][i] == currentPlayer && board[2][i] == currentPlayer) {
        return true;
      }
    }

    // Check diagonals
    if (board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer ||
        board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer) {
      return true;
    }

    return false;
  }

  bool isBoardFull() {
    return board.every((row) => row.every((cell) => cell != ' '));
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void play() {
    print('Welcome to Tic-Tac-Toe!');
    printBoard();

    do {
      int row, col;
      do {
        print('\nPlayer $currentPlayer, enter your move (1-9): ');
        var input = int.tryParse(stdin.readLineSync() ?? '');
        if (input != null && input >= 1 && input <= 9) {
          row = (input - 1) ~/ 3;
          col = (input - 1) % 3;
        } else {
          print('Invalid input. Enter a number between 1 and 9.');
        }
      } while (!makeMove(row, col));

      printBoard();

      if (checkWin()) {
        print('Player $currentPlayer wins!');
        break;
      }

      if (isBoardFull()) {
        print('It\'s a draw!');
        break;
      }

      switchPlayer();
    } while (true);
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.play();
}
