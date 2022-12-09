require 'rspec'
require './day8'

RSpec.describe World do
  let(:world) do
    World.new([[1, 2, 3],
               [4, 5, 6],
               [7, 8, 9]])
  end

  describe '#height_for' do
    it 'checks the height for a given coordinate' do
      expect(world.height_for(0, 0)).to eq 1
      expect(world.height_for(1, 0)).to eq 2
      expect(world.height_for(2, 0)).to eq 3
      expect(world.height_for(0, 1)).to eq 4
      expect(world.height_for(1, 1)).to eq 5
      expect(world.height_for(2, 1)).to eq 6
      expect(world.height_for(0, 2)).to eq 7
      expect(world.height_for(1, 2)).to eq 8
      expect(world.height_for(2, 2)).to eq 9
    end
  end

  describe '#heights_above' do
    it 'does not show anything above the top line' do
      expect(world.heights_above(0, 0)).to eq []
    end

    it 'gives an array of heights above' do
      expect(world.heights_above(1, 2)).to eq [2, 5]
    end
  end
  describe '#heights_below' do
    it 'does not show anything below the bottom line' do
      expect(world.heights_below(0, 2)).to eq []
    end

    it 'gives an array of heights below' do
      expect(world.heights_below(0, 0)).to eq [4, 7]
    end
  end
  describe '#heights_left' do
    it 'gives an array of heights left' do
      expect(world.heights_left(2, 0)).to eq [1, 2]
    end
  end

  describe '#heights_right' do
    it 'does not show anything right of the right edge' do
      expect(world.heights_right(2, 0)).to eq []
    end

    it 'gives an array of heights right' do
      expect(world.heights_right(0, 0)).to eq [2, 3]
    end
  end

  describe '#visible_from_an_edge?' do
    let(:world) do
      World.new([[3, 0, 3, 7, 3],
                 [2, 5, 5, 1, 2],
                 [6, 5, 3, 3, 2],
                 [3, 3, 5, 4, 9],
                 [3, 5, 3, 9, 0]])
    end

    it 'returns false when a tree is hidden' do
      expect(world.visible_from_an_edge?(3,1)).to be false
    end

    it 'returns true when a tree is visible' do
      expect(world.visible_from_an_edge?(1,1)).to be true
    end
  end

  describe '#scenic_score' do
    let(:world) do
      World.new([[3, 0, 3, 7, 3],
                 [2, 5, 5, 1, 2],
                 [6, 5, 3, 3, 2],
                 [3, 3, 5, 4, 9],
                 [3, 5, 3, 9, 0]])
    end

    it 'determines the scenic score for a tree' do
      expect(world.scenic_score(2, 3)).to eq 8
    end
  end
end
