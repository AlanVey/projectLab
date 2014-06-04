json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :description, :user_id, :project_id, :difficulty, :priority
  json.url task_url(task, format: :json)
end
