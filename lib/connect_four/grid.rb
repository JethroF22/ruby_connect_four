class Grid
    attr_accessor :game_grid

    def initialize(output, input)
        @game_grid = Array.new(6) {Array.new(7, " ")}
        @output = output
        @input = input
    end

    def print_grid
        @output.puts create_grid_string
    end

    def create_grid_string
        string = ""
        column_indices = %w{1 2 3 4 5 6 7}
        string_format = "|%s" * @game_grid[0].length + "|\n"
        (@game_grid.length + 1).times do |num|
            if num == 0
                string += " " + column_indices.join(" ") + "\n"
            else
                string += (string_format % @game_grid[num - 1])
            end
        end
        string
    end

    def get_index
        index = ""
        @output.puts "Enter the column where you would like to play:"
        index = @input.gets.chomp
        if !(/\d{1}/.match(index))
            @output.puts "The format of the input was invalid"
        else
            y = index.to_i
            y = y.to_i
            if (y > @game_grid[0].length)
                @output.puts "The index was out of range"
            else
                return y - 1
            end
        end
    end

    def insert_at_given_index(symbol)
        y = get_index
        loop do
            break if (y.kind_of? Integer)
            @output.puts "Please enter a valid index"
            y = get_index
        end
        row_indices = (0..5).to_a
        x = 5
        while x >= 0
            if @game_grid[x][y] == " "
                break
            end
            x -= 1
        end
        @game_grid[x][y] = symbol
    end

    def full?
        @game_grid.each do |row|
            return false if row.any? {|value| value == " "}
        end
        true
    end

    def winning_row? (symbol)
        x = 5
        while x >= 0
            number_of_empty_slots = @game_grid[x].count{|value| value == " "}
            if number_of_empty_slots >= 3
                break
            else
                4.times do |i|
                    slice_start, slice_end = i, i + 3
                    row_slice = @game_grid[x][slice_start..slice_end]
                    if row_slice.join("") == symbol * 4
                        return true
                    end
                end
            end
            x -= 1
        end
        false
    end

    def winning_column? (symbol)
        7.times do |j|
            number_of_empty_slots = @game_grid.inject(0){|sum, row| sum + (row[0] == " " ? 1 : 0)}
            if number_of_empty_slots >= 2
                next
            else
                column = @game_grid.map { |row| row[j] }
                4.times do |i|
                    slice_start, slice_end = i, i + 3
                    column_slice = column[slice_start..slice_end]
                    if column_slice.join("") == symbol * 4
                        return true
                    end
                end
            end
        end
        false
    end

    def winning_diagonal? (symbol)
        diagonals = []
        3.times do |i|
            top_down_row_indices = (i..i + 3).to_a
            column_indices = top_down_row_indices
            start, end_ = (5 - (i + 3)), (5 - i)
            bottom_up_row_indices = (start..end_).to_a.reverse
            4.times do |j|
                diagonals.push(top_down_row_indices.zip(column_indices))
                diagonals.push(bottom_up_row_indices.zip(column_indices))
                column_indices = column_indices.map {|index| index + 1}
            end
        end
        diagonals.each do |diagonal|
            grid_diagonal = []
            diagonal.each do |x, y|
                grid_diagonal.push(@game_grid[x][y])
            end
            if grid_diagonal.join("") == symbol * 4
                return true
            end
        end
        false
    end

end
