Sequel.migration do
  change do
    create_table(:todos) do
      uuid         :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      text         :title, null: false
      FalseClass   :completed, default: false, null: false
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
    end
  end
end
