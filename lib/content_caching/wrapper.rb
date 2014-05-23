module ContentCaching
  class Wrapper < Struct.new(:path)
    def to_path
      self.path
    end
  end
end
