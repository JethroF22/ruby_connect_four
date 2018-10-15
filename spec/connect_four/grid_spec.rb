require "spec_helper"

describe Grid, :grid => true do
    let(:output) { double('output').as_null_object }
    let(:input) { double('input').as_null_object }
    let(:grid) {Grid.new(output, input)}

    context "on instantiation" do
        it "creates an 6x7 array containing only spaces" do
            expect(grid.game_grid).to eq(Array.new(6) {Array.new(7, " ")})
        end
    end

    context "#print_board" do
        it "prints a string representation of the grid" do
            expect(output).to receive(:puts).with(create_grid_string)
            grid.print_grid
        end
    end

    context "#get_index", :get_index => true do
        it "prompts the player to input which column they would like to play in" do
            string = "Enter the column where you would like to play:"
            expect(output).to receive(:puts).with(string)
            grid.get_index
        end

        it "accepts column number from player" do
            allow(input).to receive(:gets).and_return("4")
            expect(grid.get_index).to eq(4)
        end

        it "prints an error message if the player inputs an invalid position" do
            allow(input).to receive(:gets).and_return("invalid input")
            string = "The format of the input was invalid"
            expect(output).to receive(:puts).with(string)
            grid.get_index
        end

        it "prints an error message if the given index is out of range" do
            allow(input).to receive(:gets).and_return("8")
            string = "The index was out of range"
            expect(output).to receive(:puts).with(string)
            grid.get_index
        end
    end

    context "#insert_at_given_index", :insert => true do
        let(:symbol) {"x"}

        context "the bottom-most row is filled first" do
            it "inserts the player symbol into the bottom row if the space is empty" do
                allow(input).to receive(:gets).and_return("4")
                grid.insert_at_given_index(symbol)
                expect(grid.game_grid[5][4]).to eq(symbol)
            end

            it "inserts the player symbol into the second-last row if the space in the bottom-row is full" do
                populate_last_row(grid.game_grid)
                allow(input).to receive(:gets).and_return("4")
                grid.insert_at_given_index(symbol)
                expect(grid.game_grid[4][4]).to eq(symbol)
            end

        end

        it "prompts the user re-enter an index if the index is invalid" do
            allow(input).to receive(:gets).and_return("8")
            allow(grid).to receive(:loop).and_yield
            expect(output).to receive(:puts).with("Please enter a valid index")
            grid.insert_at_given_index(symbol)
        end
    end

    context "#full?" do
        it "returns true if the grid contains only non-space values" do
            populate_grid(grid.game_grid)
            expect(grid.full?).to be(true)
        end
    end

    context "winning_row?" do
        it "returns false if there are four or less played slots in a row" do
            grid.game_grid[5] = [" ", "x", "o", "x", " ", " ", " "]
            expect(grid.winning_row?("x")).to be(false)
        end

        it "returns true if player has four symbols lined up consecutively in a row" do
            populate_winning_row(grid.game_grid)
            expect(grid.winning_row?("x")).to be(true)
        end
    end

    context "winning_column?" do
        it "returns false if there are four or less played slots in a column" do
            expect(grid.winning_column?("x")).to be(false)
        end

        it "returns true if player has four symbols lined up consecutively in a column" do
            populate_winning_column(grid.game_grid)
            expect(grid.winning_column?("x")).to be(true)
        end
    end

    context "winning_diagonal?" do
        it "returns true if player has four symbols lined up consecutively in a diagonal" do
            populate_winning_diagonal(grid.game_grid)
            expect(grid.winning_diagonal?("x")).to be(true)
        end
    end
end
