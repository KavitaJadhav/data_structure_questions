# Permission manager handles roles per user
class PermissionManager
  def initialize
    @permissions = {} # user_id => role
  end

  def set_permission(user_id, role)
    @permissions[user_id] = role
  end

  def get_role(user_id)
    @permissions[user_id] || :none
  end

  def allow?(user_id, action)
    role = get_role(user_id)
    case role
    when :owner
      true
    when :write
      action != :read
    when :read
      action == :read
    else
      false
    end
  end
end

# Base Node class
class Node
  attr_accessor :name, :parent, :permissions

  def initialize(name, parent=nil)
    @name = name
    @parent = parent
    @permissions = PermissionManager.new
  end

  def path
    return "/" if parent.nil?
    parent_path = parent.path == "/" ? "" : parent.path
    "#{parent_path}/#{name}"
  end
end

# File with versioning
class FileNode < Node
  attr_accessor :versions

  def initialize(name, parent=nil)
    super(name, parent)
    @versions = []
  end

  def write(content, user_id=nil)
    check_permission(user_id, :write)
    @versions << content
  end

  def read(user_id=nil)
    check_permission(user_id, :read)
    @versions.last
  end

  def rollback(version_index)
    raise "Invalid version" if version_index < 0 || version_index >= versions.size
    @versions = versions[0..version_index]
  end

  private

  def check_permission(user_id, action)
    return if user_id.nil?
    raise "Permission denied for #{action}" unless permissions.allow?(user_id, action)
  end
end

# Directory holding children
class DirectoryNode < Node
  attr_accessor :children

  def initialize(name, parent=nil)
    super(name, parent)
    @children = {}
  end

  def add_node(node)
    raise "Node exists" if children.key?(node.name)
    children[node.name] = node
    node.parent = self
  end

  def get_node(name)
    children[name]
  end

  def list
    children.keys
  end
end

# Path traversal and parent lookup
class PathService
  def initialize(root)
    @root = root
  end

  def find_node(path)
    parts = path.split("/").reject(&:empty?)
    node = @root
    parts.each do |part|
      node = node.get_node(part)
      raise "Path not found: #{part}" if node.nil?
    end
    node
  end

  def find_parent(path)
    parts = path.split("/").reject(&:empty?)
    name = parts.pop
    parent = @root
    parts.each do |part|
      parent = parent.get_node(part)
      raise "Directory not found: #{part}" if parent.nil? || !parent.is_a?(DirectoryNode)
    end
    [parent, name]
  end
end

# Main FileSystem class
class FileSystem
  attr_accessor :root, :path_service

  def initialize
    @root = DirectoryNode.new("/")
    @path_service = PathService.new(@root)
  end

  def mkdir(path)
    parent, name = path_service.find_parent(path)
    raise "Directory exists" if parent.get_node(name)
    parent.add_node(DirectoryNode.new(name, parent))
  end

  def write_file(path, content, user_id=nil)
    parent, name = path_service.find_parent(path)
    node = parent.get_node(name)
    if node.nil?
      node = FileNode.new(name, parent)
      parent.add_node(node)
    end
    node.write(content, user_id)
  end

  def read_file(path, user_id=nil)
    node = path_service.find_node(path)
    raise "Not a file" unless node.is_a?(FileNode)
    node.read(user_id)
  end

  def list_dir(path)
    node = path_service.find_node(path)
    raise "Not a directory" unless node.is_a?(DirectoryNode)
    node.list
  end
end

# Example usage
fs = FileSystem.new
fs.mkdir("/docs")
fs.write_file("/docs/file1.txt", "v1 content")
fs.write_file("/docs/file1.txt", "v2 content")
puts fs.read_file("/docs/file1.txt") # => "v2 content"
fs.list_dir("/docs") # => ["file1.txt"]