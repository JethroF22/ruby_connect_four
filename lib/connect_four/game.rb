class Game
    attr_accessor :current_player, :grid

    def initialize(output, input)
        @output = output
        @player_1 = Player.new("x")
        @player_2 = Player.new("o")
        @current_player = @player_1
        @grid = Grid.new(output, input)
    end

    def start
       @output.puts "Welcome to Connect Four!"
       @output.puts "" + @current_player.symbol + " to start"
    end

    def game_over?
        if @grid.full?
            @output.puts "Game over!"
            exit
        end
    end

    def player_wins?
        symbol = @current_player.symbol
        if (@grid.winning_diagonal?(symbol)) || (@grid.winning_row?(symbol)) || (@grid.winning_column?(symbol))
            return true
        else
            return false
        end
    end

    def main
        loop do
            @output.puts "Current player: " + @current_player.symbol
            @grid.print_grid
            @grid.insert_at_given_index(@current_player.symbol)
            if player_wins?
                @output.puts "" + (@current_player == @player_1 ? "Player 1" : "Player 2") + " wins!"
                exit
            end
            game_over?
            @current_player = (@current_player == @player_1 ? @player_2 : @player_1)
        end
    end
end
