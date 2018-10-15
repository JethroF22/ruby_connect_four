require "spec_helper"

describe Game, :game => true do
    let(:output) { double('output').as_null_object }
    let(:input) { double('input').as_null_object }
    let(:player_1) { double('player') }
    let(:player_2) { double('player') }
    let(:game) { Game.new(output,input) }


    before(:each){
        allow(player_1).to receive("symbol") {"x"}
        allow(player_2).to receive("symbol") {"o"}

    }

    context "#start" do
        it "sends a welcome message" do
            expect(output).to receive(:puts).with("Welcome to Connect Four!")
            game.start
        end

        it "informs the players which player will start" do
            expect(output).to receive(:puts).with("" + player_1.symbol + " to start")
            game.start
        end

        it "sets the current player to player_1" do
            game.start
            expect(game.current_player.symbol).to eq(player_1.symbol)
        end
    end

    context "#game_over?" do
        it "informs the players that the game is over" do
            expect(output).to receive(:puts).with("Game over!")
            populate_grid(game.grid.game_grid)
            game.game_over?
        end
    end

    context "#player_wins?" do
        it "returns true if any of the winning conditions are met" do
            populate_winning_row(game.grid.game_grid)
            expect(game.player_wins?).to be(true)
        end
    end

    context "#main" do

        it "changes the current player every turn" do
            allow(game).to receive(:loop).and_yield
            allow(input).to receive(:gets).and_return("4")
            game.main
            expect(game.current_player.symbol).to eq(player_2.symbol)
        end

        it "informs the player if they win" do
            allow(game).to receive(:loop).and_yield
            allow(input).to receive(:gets).and_return("4")
            populate_winning_row(game.grid.game_grid)
            expect(output).to receive(:puts).with("Player 1 wins!")
            game.main
        end


    end
end
