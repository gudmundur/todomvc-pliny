module Mediators::Todos
  class Updater < Mediators::Base
    attr_reader :todo, :title, :completed
    def initialize(args)
      @todo = args.fetch(:todo)
      @title = args.fetch(:title, nil)
      @completed = args.fetch(:completed, nil)
    end

    def call
      log do
        update_title
        update_completed
        self
      end
    end

    private

    def update_title
      return if title.nil?
      todo.update(title: title)
    end

    def update_completed
      return if completed.nil?
      todo.update(completed: completed)
    end

    def log(data={}, &blk)
      data.merge!(
        todos: true,
        updater: true,
        title: title,
        completed: completed
      )

      Pliny.log(data, &blk)
    end

  end
end
