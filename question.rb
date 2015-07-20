class Question

  def self.print(message:, prompt: ">>", &blk)
    puts message
    yield
    puts prompt
  end

end
