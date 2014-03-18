require_relative '../src/robot'

describe Robot do

  context '.new' do
    shared_context 'constructor' do |x, y|
      let(:robot) { Robot.new x, y }
      it "creates a robot properly within bounds" do
        expect(robot).to be_a(Robot)
      end
      it 'puts robot at proper coords' do
        expect(robot.x).to eq x
        expect(robot.y).to eq y
      end
    end
    shared_context 'error raiser' do |x, y, exc_class|
      it "raises error" do
        expect{Robot.new x, y}.to raise_exception(exc_class)
      end
    end

    context 'with proper arguments' do
      it_should_behave_like 'constructor', 2, 2
      it_should_behave_like 'constructor', 0, 4
      it_should_behave_like 'constructor', 4, 1
    end

    context "when out of bounds" do
      it_should_behave_like 'error raiser', -1, 0, ArgumentError
      it_should_behave_like 'error raiser', 6, 3, ArgumentError
      it_should_behave_like 'error raiser', 2, -3, ArgumentError
      it_should_behave_like 'error raiser', 2, 5, ArgumentError
    end
  end

  context '#teleport' do
    shared_context 'teleporter' do |x, y, oldx, oldy|
      if x.between?(0,4) && y.between?(0,4)
        it 'puts robot at proper coords' do
          robot.teleport x, y
          expect(robot.x).to eq x
          expect(robot.y).to eq y
        end
      else
        it 'returns false' do
          expect(robot.teleport x, y).to be_false
        end
        it 'does not change robot`s position' do
          robot.teleport x, y
          expect(robot.x).to eq oldx
          expect(robot.y).to eq oldy
        end
      end
    end

    let(:robot) { Robot.new 2, 2 }

    it_should_behave_like "teleporter", 3, 1, 2, 2
    it_should_behave_like "teleporter", 3, 2, 2, 2
    it_should_behave_like "teleporter", 0, 4, 2, 2
    it_should_behave_like "teleporter", 2, 0, 2, 2
    it_should_behave_like "teleporter", 5, 4, 2, 2
    it_should_behave_like "teleporter", 2, -1, 2, 2
  end

  context '#move' do
    shared_context 'mover' do |oldx, oldy, facing|
      let(:robot) {Robot.new oldx, oldy}
      before {robot.f = facing}
      if (oldx + facing[1]).between?(0,4) && (oldy+facing[0]).between?(0,4)
        it 'it should move ahead' do
          robot.move
          expect(robot.x).to eq (oldx + facing[1])
          expect(robot.y).to eq (oldy + facing[0])
        end
      else
        it 'returns false' do
          expect(robot.move).to be_false
        end
        it 'does not change robot`s position' do
          robot.move
          expect(robot.x).to eq oldx
          expect(robot.y).to eq oldy
        end
      end
    end

    it_should_behave_like 'mover', 2, 2, [0,-1]
    it_should_behave_like 'mover', 2, 2, [0,1]
    it_should_behave_like 'mover', 3, 2, [1,0]
    it_should_behave_like 'mover', 2, 0, [0,-1]
    it_should_behave_like 'mover', 0, 4, [0,-1]
    it_should_behave_like 'mover', 0, 4, [1,0]
    it_should_behave_like 'mover', 4, 4, [0,1]
  end

  context '#rotate' do
    shared_context 'rotator' do |old_facing, new_facing, direction|
      let(:robot) {Robot.new 2, 2}
      before {robot.f = old_facing}
      if direction > 1
        it 'it should rotate clockwise' do
          robot.rotate direction
          expect(robot.f).to eql new_facing
        end
      else
        it 'it should rotate counter-clockwise' do
          robot.rotate direction
          expect(robot.f).to eql new_facing
        end
      end
    end

    it_should_behave_like 'rotator', [1,0], [0,1], 1
    it_should_behave_like 'rotator', [0,1], [-1,0], 1
    it_should_behave_like 'rotator', [-1,0], [0,-1], 1
    it_should_behave_like 'rotator', [0,-1], [1,0], 1

    it_should_behave_like 'rotator', [0,1], [1,0], -1
    it_should_behave_like 'rotator', [-1,0], [0,1], -1
    it_should_behave_like 'rotator', [0,-1], [-1,0], -1
    it_should_behave_like 'rotator', [1,0], [0,-1], -1
  end
end