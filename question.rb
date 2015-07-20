class Question

  def self.print(message:, prompt: ">>", &blk)
    puts message
    yield if block_given?
    puts prompt
  end

end
