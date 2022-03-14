require_relative "tree_node"
require 'byebug'

class KnightPathFinder

    def initialize(pos)
        @start_pos = pos # [0,0]
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
        build_move_tree
        
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

    def build_move_tree
        queue = [@root_node]
        until queue.empty? 
            current_node = queue.shift  
            new_move_positions(current_node.value).each do |el|
                new_node = PolyTreeNode.new(el)
                current_node.add_child(new_node)
                queue << new_node
            end
        end
    end

    def find_path(end_pos)
        result = @root_node.dfs(end_pos)
        p trace_path_back(result)
    end

    def trace_path_back(end_node)
        arr = []
        current_node = end_node
        until current_node.parent == nil
            parent = current_node.parent
            arr << current_node
            current_node = parent
        end
        [@start_pos] + arr.map { |node| node.value }.reverse
    end
   

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos) - @considered_positions
        @considered_positions += new_moves
        new_moves
    end 
end

knight = KnightPathFinder.new([0,0])
knight.build_move_tree
knight.find_path([3,4])

