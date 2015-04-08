module Mediators::Todos
  class Creator < Mediators::Base
    attr_reader :title, :completed
    attr_reader :todo

    def initialize(args)
      @title = args.fetch(:title)
      @completed = args.fetch(:completed, false)
    end

    def call
      log do
        create_todo
        self
      end
    end

    private

    def create_todo
      @todo ||= Todo.create(
        title: title,
        completed: completed
      )
    end

    def log(data={}, &blk)
      data.merge!(
        todos: true,
        creator: true,
        title: title
      )

      Pliny.log(data, &blk)
    end
  end
end
