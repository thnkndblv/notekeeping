require_relative 'permission/base_decorator'
require_relative 'permission/read_decorator'
require_relative 'permission/update_decorator'
require_relative 'permission/own_decorator'

class NotePermissions
  class << self
    def assign_permissions(note, target_user)
      note.tap do |n|
        n.extend(::Permission::BaseDecorator)
        graph = shared_graph(note)
        traverse_graph(graph, note[:user_id], target_user.id) do |share|
          apply_permissions(share[:permission], n)
        end
      end
    end

    # Decorates the note to add permissions based on the permission level
    def apply_permissions(permission, note)
      case permission.to_sym
      when :none
        note.extend(::Permission::BaseDecorator)
      when :read
        note.extend(::Permission::ReadDecorator)
      when :update
        note.extend(::Permission::UpdateDecorator)
      when :own
        note.extend(::Permission::OwnDecorator)
      else
        raise "Unknown permission type found: '#{new_permission}'"
      end
    end

    private

    # Performs a BFS traverse, once the target user_id is reached it is passed to the yield
    def traverse_graph(graph, source_id, target_id)
      seen = Set.new
      queue = Queue.new

      queue << source_id
      until queue.empty?
        current = queue.pop
        
        next if seen.include?(current)
        seen << current
        
        next unless graph.key?(current)

        graph[current].each do |share|
          yield(share) if block_given? && share[:to_user_id] == target_id
          queue << share[:to_user_id]
        end
      end
    end

    # Build a graph with all the shares for a given note
    def shared_graph(note)
      note
        .shares
        .actives
        .each_with_object({}) do |share, obj|
          obj[ share[:user_id] ] = [] unless obj.key?( share[:user_id] )
          obj[ share[:user_id] ] << share
        end
    end
  end
end
