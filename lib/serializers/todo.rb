class Serializers::Todo < Serializers::Base
  structure(:default) do |arg|
    {
      created_at: arg.created_at.try(:iso8601),
      id:         arg.uuid,
      title:      arg.title,
      completed:  arg.completed,
      updated_at: arg.updated_at.try(:iso8601),
    }
  end
end
