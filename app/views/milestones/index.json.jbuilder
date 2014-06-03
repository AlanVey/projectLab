json.array!(@milestones) do |milestone|
  json.extract! milestone, :id, :due_date, :completion_date, :name, :status
  json.url milestone_url(milestone, format: :json)
end
