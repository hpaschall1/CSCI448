package com.something.tictactoe;

import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;


public class MainActivity extends ActionBarActivity {

    private TheGame my_game;
    private Button my_buttons[];
    private TextView text_thrasher;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        my_buttons = new Button[9];
        my_game = new TheGame();
        text_thrasher = (TextView) findViewById(R.id.textView);

        my_buttons[0] = (Button) findViewById(R.id.button);
        my_buttons[1] = (Button) findViewById(R.id.button2);
        my_buttons[2] = (Button) findViewById(R.id.button3);
        my_buttons[3] = (Button) findViewById(R.id.button4);
        my_buttons[4] = (Button) findViewById(R.id.button5);
        my_buttons[5] = (Button) findViewById(R.id.button6);
        my_buttons[6] = (Button) findViewById(R.id.button7);
        my_buttons[7] = (Button) findViewById(R.id.button8);
        my_buttons[8] = (Button) findViewById(R.id.button9);

        for (int i = 0; i < 9; i++)
            my_buttons[i].setOnClickListener(new ButtonClickListener(i, my_game, text_thrasher, my_buttons));

    }

    private class ButtonClickListener implements View.OnClickListener
    {
        private int location;
        private TheGame the_game;
        private TextView text_thrasher;
        private Button my_buttons[];

        public void clear_buttons() {
            for (int i = 0; i < 9; i++) {
                my_buttons[i].setText(" ");
            }
        }

        public ButtonClickListener(int loc, TheGame this_game, TextView tv, Button buttons[]) {
            location = loc;
            the_game = this_game;
            text_thrasher = tv;
            my_buttons = buttons;
        }

        @Override
        public void onClick(View v) {
            Button b = (Button) v;
            char str = b.getText().toString().charAt(0);

            // If game over reset
            if (the_game.is_done()) {
                the_game.clear();
                clear_buttons();
                text_thrasher.setText(R.string.player1_turn);
                return;
            }

            // Is it a valid move?
            if (str != 'X' && str != 'O') {

                // Place piece
                if (the_game.who_dat_player()) {
                    b.setText("O");
                    the_game.place_piece(location, 'O');
                } else {
                    b.setText("X");
                    the_game.place_piece(location, 'X');
                }
                the_game.flip_player();


                if (the_game.is_done()) {
                    // If game is done show winner
                    if (the_game.who_dat_winner() == 'X') {
                        text_thrasher.setText(R.string.player1_win);
                    } else if (the_game.who_dat_winner() == 'O') {
                        text_thrasher.setText(R.string.player2_win);
                    } else if (the_game.stalemate()) {
                        text_thrasher.setText(R.string.stalemate);
                    }
                } else {
                    // Otherwise show turn
                    if (the_game.who_dat_player()) {
                        text_thrasher.setText(R.string.player2_turn);
                    } else {
                        text_thrasher.setText(R.string.player1_turn);
                    }
                }

            }
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
