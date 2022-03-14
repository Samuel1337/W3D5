class PolyTreeNode
     
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = [] 
    end

    def parent=(new_parent)
        @parent.children.delete(self) if @parent != nil
        @parent = new_parent
        new_parent.children << self if @parent != nil
    end

    def add_child(child_node)
        child_node.parent = self
        @children << child_node
        return child_node
    end



    def remove_child(child_node)
        if child_node.parent == nil
            raise RuntimeError.new 'node is not a child'
        else
            child_node.parent = nil
        end
    end

    def dfs(target_value)
        return self if @value == target_value
        self.children.each do |child|
            memo = child.dfs(target_value)
            return memo if memo != nil
        end
        nil
    end


    def bfs(target_value)
        queue = [self]
        until queue.empty?
            current_node = queue.shift 
            if current_node.value == target_value
                return current_node
            else 
                queue += current_node.children
            end
        end
        nil
    end

end

