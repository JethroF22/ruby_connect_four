require "spec_helper"

describe Player, :player => true do
    context "on instantiation" do
        it "sets the symbol attribute to the given argument" do
            player = Player.new('x')
            expect(player.symbol).to eq('x')
        end
    end
end
