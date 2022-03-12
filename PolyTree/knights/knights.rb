require_relative "tree_node"

class KnightPathFinder

    attr_reader :pos

    def initialize(pos)
        @current_pos = pos
        @root_node = PolyTreeNode.new(pos)
        build_move_tree
        @considered_positions = [pos]
    end


                            
    def self.valid_moves(pos) 
        
        moves = []

        x,y = pos

        moves << [x-2,y-1] if (0...8).include?(x-2) && (0...8).include?(y-1)
            
        moves << [x-2,y+1] if (0...8).include?(x-2) && (0...8).include?(y+1)

        moves << [x-1,y+2] if (0...8).include?(x-1) && (0...8).include?(y+2)

        moves << [x-1,y-2] if (0...8).include?(x-1) && (0...8).include?(y-2)
            
        moves << [x+1,y-2] if (0...8).include?(x+1) && (0...8).include?(y-2)

        moves << [x+1,y+2] if (0...8).include?(x+1) && (0...8).include?(y+2)
            
        moves << [x+2,y-1] if (0...8).include?(x+2) && (0...8).include?(y-1)

        moves << [x+2,y+1] if (0...8).include?(x+2) && (0...8).include?(y+1)
        
        moves
    end

    def [](pos)
        x, y = pos
        @pos[x][y]
    end

    def build_move_tree
        queue = [@root_node]
        tree = [@root_node]
        cur_pos = @current_pos
        until queue.empty?
            current = queue.shift
            nodes = new_move_positions(cur_pos).map do |move|
                cur_pos = move
                current.add_child(PolyTreeNode.new(move))
            end
            queue += nodes
            tree += nodes
        end
       
        return tree
    end

    def find_path

    end

    def new_move_positions(pos)
        # puts KnightPathFinder.valid_moves(pos) 
        KnightPathFinder.valid_moves(pos) - @considered_positions
    end 
end

# knight = KnightPathFinder.new([0,0])