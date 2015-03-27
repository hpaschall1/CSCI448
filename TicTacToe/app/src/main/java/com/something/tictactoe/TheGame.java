package com.something.tictactoe;

import android.util.Log;

public class TheGame {
    public static final int BOARD_SIZE = 9;
    public static final char PLAYER1 = 'X';
    public static final char PLAYER2 = 'O';
    public static final char EMPTY = ' ';

    private boolean  turn = false; // False = X, True = O
    private boolean  game_finished = false;
    private char the_board[];

    public TheGame() {
        the_board = new char[BOARD_SIZE];
        clear();
    }

    public void place_piece(int loc, char piece) {
        the_board[loc] = piece;
    }

    public void clear() {
        for (int i = 0; i < BOARD_SIZE; i++)
            the_board[i] = EMPTY;
        game_finished = false;
        turn = false;
    }

    public void flip_player() {
        turn = !turn;
    }

    public boolean who_dat_player() {
        return turn;
    }

    public char who_dat_winner() {
        char instant_karma = EMPTY;

        // Check Cols
        for (int i = 0; i < 3; i++) {
            instant_karma = check_col(i);
            if (instant_karma != EMPTY) {
                game_finished = true;
                return instant_karma;
            }
        }

        // Check Rows
        for (int i = 0; i < 3; i++) {
            instant_karma = check_row(i);
            if (instant_karma != EMPTY) {
                game_finished = true;
                return instant_karma;
            }
        }

        // Diagonals
        instant_karma = check_diag();
        if (instant_karma != EMPTY) {
            game_finished = true;
            return instant_karma;
        }

        return EMPTY;
    }

    public boolean is_done() {
        who_dat_winner();
        stalemate();

        return game_finished;
    }

    private char check_col(int col_num) {
        char instant_karma = EMPTY;
        int run = 0;

        // We didn't want to use if statement hell so here is algo for col check
        if (the_board[col_num] != 'X' && the_board[col_num] != 'O') {
            return EMPTY;
        }

        instant_karma = the_board[col_num];
        run++;

        for (int i = col_num+3; i < col_num+7; i += 3) {

            if (instant_karma != the_board[i]) {
                return EMPTY;
            } else {
                run++;
            }
        }

        if (run < 3) {
            return EMPTY;
        }

        return instant_karma;
    }

    private char check_row(int row_num) {
        char instant_karma = EMPTY;
        int run = 0;

        // Proper zipcode affiliate
        if (the_board[row_num*3] != EMPTY) {
            instant_karma = the_board[row_num*3];
            run++;
        } else {
            return EMPTY;
        }

        for (int i = row_num*3+1; i < row_num*3+3; i++) {
            if (instant_karma == the_board[i]) {
               run++;
            } else {
                return EMPTY;
            }

        }

        if (run < 3) {
            return EMPTY;
        }

        return instant_karma;
    }

    private char check_diag() {
        if (the_board[0] != EMPTY && the_board[0] == the_board[4] && the_board[0] == the_board[8])
            return the_board[0];

        if (the_board[6] != EMPTY && the_board[6] == the_board[4] && the_board[6] == the_board[2])
            return the_board[6];
        return EMPTY;
    }

    public boolean stalemate() {
        int taken = 0;
        for (int i = 0; i < BOARD_SIZE; i++) {
            if (the_board[i] == 'X' || the_board[i] == 'O')
                taken++;
        }
        if (taken < BOARD_SIZE)
            return false;

        game_finished = true;
        return true;
    }


}
