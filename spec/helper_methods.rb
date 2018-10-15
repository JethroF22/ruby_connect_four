def create_grid_string
    column_indices = %w{1 2 3 4 5 6 7}
    string_format = "|%s" * 7 + "|\n"
    grid_string = ""
    grid = Array.new(6, " ") { Array.new(7, " ")}
    7.times do |num|
        if num == 0
            grid_string += " " + column_indices.join(" ") + "\n"
        else
            grid_string += (string_format % grid[num - 1])
        end
    end
    grid_string
end

def populate_grid(grid)
    grid.each_index do |i|
        grid[i].each_index do |j|
            grid[i][j] = ["x", "o"][rand(0..1)]
        end
    end
end

def populate_last_row(grid)
    grid[5].each_index do |i|
        grid[5][i] = ["x", "o"][rand(0..1)]
    end
end

def populate_winning_row(grid)
    random_row = rand(0..5)
    grid.each_index do |i|
        if i == random_row
            row = ["x"] * 4 + ["o"] * 3
            grid[i] = row
        else
            grid[i].each_index do |j|
                grid[i][j] = ["x", "o"][rand(0..1)]
            end
        end
    end
end

def populate_winning_column(grid)
    random_column = rand(0..6)
    7.times do |j|
        if j == random_column
            column = ["x"] * 4 + ["o"] * 3
            6.times do |i|
                grid[i][j] = column[i]
            end
        else
            6.times do |i|
                grid[i][j] = ["x", "o"][rand(0..1)]
            end
        end
    end
end

def populate_winning_diagonal(grid)
    diagonal = [[0,0], [1, 1], [2, 2], [3, 3]]
    grid.each_index do |i|
        grid[i].each_index do |j|
            if diagonal.include? [i, j]
            grid[i][j] = "x"
            else
                grid[i][j] = ["x", "o"][rand(0..1)]
            end
        end
    end
end
