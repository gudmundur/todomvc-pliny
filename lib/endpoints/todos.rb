module Endpoints
  class Todos < Base
    namespace "/todos" do
      use Committee::Middleware::RequestValidation, schema: JSON.parse(File.read(File.join(Config.root, 'schema/schema.json')))

      before do
        content_type :json, charset: 'utf-8'
      end

      get do
        encode serialize(Todo.all)
      end

      post do
        creator = Mediators::Todos::Creator.run(
          title: body_params['title'],
          completed: body_params['completed'],
        )

        status 201
        encode serialize(creator.todo)
      end

      get "/:id" do |id|
        todo = Todo.first(uuid: id) || halt(404)
        encode serialize(todo)
      end

      patch "/:id" do |id|
        todo = Todo.first(uuid: id) || halt(404)

        updater = Mediators::Todos::Updater.run(
          todo: todo,
          title: body_params['title'],
          completed: body_params['completed'],
        )
        encode serialize(updater.todo)
      end

      delete "/:id" do |id|
        todo = Todo.first(uuid: id) || halt(404)
        todo.destroy
        encode serialize(todo)
      end

      private

      def serialize(data, structure = :default)
        Serializers::Todo.new(structure).serialize(data)
      end
    end
  end
end
