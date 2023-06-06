private Cell[][] board;

private int cols = 3;
private int rows = 3;

private int cellsLeft = 9; // number of remaining empty cells
private int player = 0; //0 = player1, 1 = player2
private int win = 0;  // 1 = player1 X   2 = player2 0
private int game = 0;  // 1 = selection mode, 2 = game started
private int mode =0; // 1 is one player and 2 is two player
